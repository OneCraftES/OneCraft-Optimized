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
   - [ ] Update CurseForge metadata
   - [ ] Update Modrinth metadata
   - [ ] Update MultiMC instance information

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

3. [x] Mod Management:
   - [x] Review INCLUDED-MODS.md
   - [x] Document any mod changes specific to OneCraft
   - [x] Update mod configuration files if needed

## Distribution Preparation

1. [ ] Platform Setup:
   - [ ] Create new project pages on CurseForge
   - [ ] Create new project page on Modrinth
   - [ ] Set up new documentation website if needed

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
