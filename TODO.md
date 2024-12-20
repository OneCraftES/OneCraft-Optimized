# OneCraft Optimized - Fork Plan

This document outlines the steps needed to properly fork and rebrand Fabulously Optimized into OneCraft Optimized while maintaining upstream compatibility and respecting the original project's license.

## Legal Requirements

1. [x] Update LICENSE.md to include:
   - [x] Original copyright notice
   - [x] Acknowledgment of Fabulously Optimized as the original source
   - [x] Your own copyright notice for new modifications

2. [x] Ensure compliance with BSD 3-Clause License:
   - [x] Maintain original copyright notices
   - [x] Include original license text
   - [x] Do not use FO branding to promote the fork without permission

## Branding Changes

1. [ ] Replace Fabulously Optimized branding:
   - [ ] Update logo and icons
   - [ ] Replace `cape.png` with new design
   - [x] Update README.md with OneCraft Optimized branding
   - [ ] Create new badges and shields for documentation

2. [x] Update metadata files:
   - [x] Modify pack.toml in Packwiz directory
   - [x] Update CurseForge metadata
   - [x] Update Modrinth metadata
   - [x] Update MultiMC instance information

## Documentation Updates

1. [x] Update main documentation:
   - [x] README.md
   - [x] CHANGELOG.md (start fresh, reference FO version as base)
   - [x] CONTRIBUTING.md
   - [x] DEVELOPER-README.md

2. [ ] Create fork-specific documentation:
   - [x] Document differences from Fabulously Optimized
   - [ ] Create upgrade guide for users
   - [x] Document sync strategy with upstream

## Technical Changes

1. [x] Repository Setup:
   - [x] Clean up .git directory
   - [x] Set up new remote for upstream
   - [x] Configure .gitignore for fork-specific files

2. [x] Configuration Files:
   - [x] Review and update crowdin.yml if maintaining translations
   - [ ] Update CI/CD workflows in .github directory
   - [x] Modify pack configurations in Packwiz directory
   - [x] Update MultiMC configurations
   - [x] Update MultiMC-Packwiz auto-update configurations

3. [x] Mod Management:
   - [x] Review INCLUDED-MODS.md
   - [x] Document any mod changes specific to OneCraft
   - [x] Update mod configuration files if needed

## Distribution Preparation

1. [ ] Platform Setup:
   - [x] CurseForge Project:
     - [x] Update manifest.json with OneCraft information
     - [x] Create project page
     - [x] Set up project description
     - [x] Configure project settings
     - [ ] Add required screenshots
     - [x] Set up proper dependencies
     - [x] Configure version tracking

   - [x] Modrinth Project:
     - [x] Update modrinth.index.json with project metadata
     - [x] Create project page
     - [x] Set up project description
     - [x] Configure project settings
     - [ ] Add required screenshots
     - [x] Set up proper dependencies
     - [x] Configure version tracking

   - [ ] MultiMC Distribution:
     - [x] Update instance configurations
     - [x] Update auto-update configurations
     - [ ] Replace pack.png with new branding
     - [x] Update GitHub repository URL in auto-update configuration
     - [ ] Test auto-update functionality

   - [ ] Documentation Website:
     - [ ] Decide on documentation platform (GitHub Pages/GitBook)
     - [ ] Set up basic structure
     - [ ] Migrate relevant documentation
     - [ ] Add installation guides

2. [ ] Release Process:
   - [ ] Create release checklist
   - [ ] Set up automated builds
   - [ ] Prepare update channels

## Maintenance Plan

1. [x] Upstream Sync Strategy:
   - [x] Define process for merging upstream updates
   - [x] Document conflict resolution procedures
   - [x] Set up automated update checks

2. [ ] Version Control:
   - [x] Establish versioning scheme
   - [ ] Document release process
   - [ ] Set up changelog automation
   - [ ] Update CLI tools for OC version prefix
   - [ ] Test version update scripts

3. [ ] GitHub Repository Setup:
   - [ ] Update FUNDING.yml with project's donation links
   - [ ] Review and update GitHub workflows
   - [ ] Review stale bot configuration

## Community and Support

1. [ ] Community Infrastructure:
   - [ ] Set up support channels
   - [x] Create issue templates
   - [x] Establish contribution guidelines

2. [ ] Documentation:
   - [ ] Create support guide
   - [x] Document known differences from upstream
   - [ ] Maintain FAQ

## Notes

- Keep track of upstream changes in Fabulously Optimized
- Document all modifications clearly
- Maintain clear communication about the relationship with the original project
- Consider contributing improvements back to upstream when applicable

## References

- Original Fabulously Optimized repository
- BSD 3-Clause License requirements
- Minecraft modpack distribution guidelines
