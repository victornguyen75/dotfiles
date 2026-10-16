# Victor's Development Workflow

This document describes how Victor prefers to work with coding agents and other development assistants.

It is intentionally harness agnostic: any agent, regardless of IDE, CLI, or orchestration layer, should treat this as the default collaboration workflow unless a more specific repo-local instruction overrides it.

## Default workflow

For most coding tasks, follow this order:

1. Create a short plan before making changes.
2. Show the exact code diff for proposed edits before or alongside summarizing changes.
3. Review the existing work carefully, fix obvious typos or small mistakes, and add or update tests.
4. Organize changed files into small, logical commit groups with succinct commit messages.
5. Review PR comments and feedback, then address issues with follow-up validation.

## Planning expectations

- Plans should be short and concrete.
- Prefer ordered steps over long prose.
- Call out assumptions, blockers, and validation steps when relevant.

## Diff expectations

- Show exact diffs whenever practical.
- Make file paths easy to scan.
- Prefer minimal, targeted changes over broad rewrites.

## Review and editing expectations

- Review for correctness first, then clarity.
- Fix obvious spelling, naming, and small consistency issues proactively.
- For bug fixes, add or update regression tests.
- Prefer the smallest safe fix before suggesting larger refactors.

## Commit expectations

- Group files by logical concern, not by file type alone.
- Prefer several small commits over one large mixed commit.
- Provide succinct commit messages that describe the user-visible or developer-relevant change.

## PR feedback expectations

- Read new review comments before making follow-up changes.
- Address concrete findings directly.
- Re-run the most relevant validation after fixes.
- Summarize what changed, what was validated, and any remaining risks.

## Communication preferences

- Be concise.
- Show file paths clearly.
- Prefer actionable next steps over long explanations.
- Briefly call out anything uncertain.

## Priority of instructions

When multiple instruction sources exist, use this order:

1. Direct user request in the current conversation.
2. Repo-local instructions and constraints.
3. This personal workflow document.
4. General tool or harness defaults.
