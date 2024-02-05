<#
.SYNOPSIS
Updating the module names list in the issue template

.DESCRIPTION
CSV data for moules and pattern is loaded and overwrites the list in the issue template. The changes are then commited to the repository.

.PARAMETER Repo
Repository name according to GitHub (owner/name)

.PARAMETER RepoRoot
Optional. Path to the root of the repository.

.EXAMPLE
Sync-AvmModulesList -Repo 'Azure/bicep-registry-modules'

.NOTES
Will be triggered by the workflow avm.platform.sync-avm-modules-list.yml
#>
function Sync-AvmModulesList {
  param (
    [Parameter(Mandatory = $true)]
    [string] $Repo,

    [Parameter(Mandatory = $false)]
    [string] $RepoRoot = (Get-Item -Path $PSScriptRoot).parent.parent.parent.parent.FullName
  )

  # Loading helper functions
  . (Join-Path $RepoRoot 'avm' 'utilities' 'pipelines' 'platform' 'Get-AvmCsvData.ps1')

  $workflowFilePath = Join-Path $RepoRoot '.github' 'ISSUE_TEMPLATE' 'avm_module_issue.yml'

  # get CSV data
  $modules = Get-AvmCsvData -ModuleIndex "Bicep-Resource" | Select-Object -Property "ModuleName"
  $patterns = Get-AvmCsvData -ModuleIndex "Bicep-Pattern" | Select-Object -Property "ModuleName"

  # build new strings
  $prefix = '        - "'
  $postfix = '"'
  $newModuleLines = $modules | ForEach-Object { $prefix + $_.ModuleName + $postfix }
  $newPatternLines = $patterns | ForEach-Object { $prefix + $_.ModuleName + $postfix }

  # parse workflow file
  $workflowFileLines = Get-Content $workflowFilePath
  $startIndex = 0
  $endIndex = 0

  for ($lineNumber = 0; $lineNumber -lt $workflowFileLines.Count; $lineNumber++) {
    if ($startIndex -gt 0 -and (-not ($workflowFileLines[$lineNumber]).Trim().StartsWith('- "avm/'))) {
      $endIndex = $lineNumber
      break
    }

    if (($workflowFileLines[$lineNumber]).Trim() -eq '- "Other, as defined below..."') {
      $startIndex = $lineNumber
    }
  }

  $oldLines = $workflowFileLines[($startIndex + 1)..($endIndex - 1)]
  $newLines = $newModuleLines + $newPatternLines
  $body = $newLines -join ([Environment]::NewLine)

  if ($oldLines -ne $newLines) {
    $title = "[AVM chore] Module(s) missing from AVM Module Issue template"
    $label = "Type: AVM :a: :v: :m:,Type: Hygiene :broom:,Needs: Triage :mag:"
    $issues = gh issue list --state open --label $label --json 'title' --repo $Repo | ConvertFrom-Json -Depth 100

    if ($issues.title -notcontains $title) {
      $issueUrl = gh issue create --title $title --body $body --label $label --repo $Repo
      $issueId = (gh issue view $issueUrl --repo $repo --json 'id'  | ConvertFrom-Json -Depth 100).id

      $project = gh api graphql -f query='
            query($organization: String! $number: Int!){
              organization(login: $organization){
                projectV2(number: $number) {
                  id
                }
              }
            }' -f organization="Azure" -F number=614 | ConvertFrom-Json -Depth 10

      $bugBoardId = $project.data.organization.projectV2.id

      gh api graphql -f query='
            mutation($project:ID!, $issue:ID!) {
              addProjectV2ItemById(input: {projectId: $project, contentId: $issue}) {
                item {
                  id
                }
              }
            }' -f project=$bugBoardId -f issue=$issueId
    } --jq '.data.addProjectV2ItemById.projectV2Item.id'
  }
}
}