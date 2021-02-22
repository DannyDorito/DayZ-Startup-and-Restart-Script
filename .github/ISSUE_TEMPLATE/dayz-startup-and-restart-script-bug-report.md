---
name: DayZ Startup and Restart Script Bug Report
about: Create a Bug Report to help improve the DayZ Startup Script!
title: "[BUG] "
labels: bug
assignees: DannyDorito

---

**Describe the bug**
A clear and concise description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Ensure any sensitive info is redacted in the script, such as Steam logon info or passwords before proceeding
2. Remove or comment out lines lines 7-12 and replace it with `@ECHO ON`
3. Open the command prompt and `cd` to the location of the script
4. Ensure any sensitive info is redacted, such as Steam logon info or passwords before
5. Run the command `DayZServerStart.bat > batch.log 2>&1`
6. Attach `batch.log` to the bug report.
7. It is difficult to debug your script without this info

**Screenshots**
If applicable, add screenshots to help explain your problem.

**Additional context**
Add any other context about the problem here.
