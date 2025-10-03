# GitHub Pages Deployment Fix

## Problem
The GitHub Pages site at `https://avc-adelaide.github.io/applied-control-systems/` was not showing the worked examples PDFs, even though the deployment workflow appeared to be working.

## Root Cause
Two GitHub Actions workflows were conflicting:

1. **`compile-examples.yml`** - Compiles LaTeX worked examples to PDFs and deploys to GitHub Pages
2. **`jekyll-gh-pages.yml`** - Builds and deploys a Jekyll site to GitHub Pages

Both workflows:
- Used the same concurrency group (`"pages"`)
- Deployed to the same GitHub Pages destination
- Were triggered on every push to the main branch

**Timeline of the conflict:**
- `compile-examples.yml` ran first, successfully deploying worked examples
- `jekyll-gh-pages.yml` ran second, overwriting the worked examples with a Jekyll site
- Result: GitHub Pages showed the Jekyll site instead of the worked examples

## Solution Applied

### 1. Disabled Jekyll Automatic Trigger
Modified `.github/workflows/jekyll-gh-pages.yml`:
- Commented out the `push` trigger that ran on every main branch push
- Kept `workflow_dispatch` so the workflow can still be manually triggered if needed
- Added documentation explaining the conflict

### 2. Documented the Fix
Added comments to both workflow files explaining:
- Why the Jekyll workflow is disabled
- What the conflict was
- Where to find more information (WORKED_EXAMPLES_SETUP.md)

### 3. Triggered Redeployment
Modified `.github/workflows/compile-examples.yml` to trigger its redeployment:
- Added a comment to the file
- This file is in the workflow's own `paths` filter, so changing it triggers the workflow
- On merge to main, this will redeploy the worked examples

## What Happens Next

When this PR is merged to main:

1. **Compile Examples Workflow Runs**
   - Triggered automatically because `.github/workflows/compile-examples.yml` was modified
   - Compiles all 9 worked example PDFs
   - Generates an index page (`index.md`)
   - Deploys everything to GitHub Pages

2. **Jekyll Workflow Does NOT Run**
   - No longer triggered automatically on push to main
   - Can still be triggered manually if needed via workflow_dispatch

3. **GitHub Pages Shows Worked Examples**
   - Visit: `https://avc-adelaide.github.io/applied-control-systems/`
   - You'll see an index page with links to all worked example PDFs
   - PDFs are organized by module and topic

## Files Modified

### `.github/workflows/jekyll-gh-pages.yml`
```yaml
# Disabled automatic trigger
# push:
#   branches: ["main"]
```

### `.github/workflows/compile-examples.yml`
```yaml
# Added explanatory comment about the fix
```

## Future Considerations

If you want to use Jekyll alongside the worked examples in the future, you have these options:

1. **Keep only worked examples** (current solution)
   - Simple, no conflicts
   - GitHub Pages shows worked examples only

2. **Use Jekyll with worked examples as a subfolder**
   - Modify Jekyll to include worked examples in a subdirectory
   - More complex but provides integrated site

3. **Separate repositories**
   - Keep worked examples in this repo
   - Create separate repo for Jekyll site with custom domain

## References

- `WORKED_EXAMPLES_SETUP.md` - Documentation on the worked examples setup
- `worked-examples/README.md` - Information about the worked examples directory
- GitHub Actions workflow logs for debugging

## Verification Steps

After merge, verify the fix by:

1. Check that the compile-examples workflow runs and completes successfully
2. Visit `https://avc-adelaide.github.io/applied-control-systems/`
3. Confirm you see the worked examples index page
4. Click on PDF links to verify they open correctly
5. Verify the Jekyll workflow did NOT run automatically

---

**Date Fixed:** 2025-10-03  
**Issue:** Bug with pages - deploy workflow working but nothing at GitHub Pages site
