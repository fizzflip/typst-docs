#import "common.typ": *

<practical-1>
#practical_title("1")

#section("Aim")[
  To install and configure a Linux (or similar) operating system in a system or virtual environment.
]

#section("Name")[
  Install and configure Linux (or alike) operating system.
]

#section("Theory")[
  Installing and configuring Linux (Ubuntu 25.10) is a foundational system administration task that introduces core operating-system concepts such as boot workflow, storage management, user provisioning, and package maintenance. In a practical environment, installation may be performed either on bare metal or inside a virtual machine; both approaches follow similar logical stages even though hardware handling differs. The installer coordinates language and locale setup, software selection, bootloader placement, and account creation to produce a ready-to-use environment.
  \
  A key technical decision during installation is disk layout. Depending on requirements, users may perform full-disk installation, dual-boot deployment, or custom partitioning. In UEFI-based systems, correct handling of EFI and primary Linux partitions is important for a stable boot process. The installer's summary view helps validate these choices before changes are written to disk.
  \
  After first boot, post-install verification is necessary to confirm the system state and configuration integrity.
  \
  #v(0.1em)
  *Post-install validation points:*
  - Confirm installed OS version and hardware detection in the system information panel.
  - Verify network connectivity and repository reachability for package operations.
  - Apply package updates and security patches to baseline the system.
  - Ensure user authentication and login policies are configured as intended.
  - Prepare the environment for future lab work by installing required tools.
]

#pagebreak()

#text(size: 14pt, weight: "bold")[Installation Walkthrough:] \
#text(
  size: 12pt,
)[Step 1: Start installation by selecting language on the initial welcome screen.] \
#align(center)[
  #figure(
    image("assets/ubuntu-25-install-01-language.png", width: 88%),
    caption: [Language selection screen.],
  )
]

#v(0.6em)
#text(
  size: 12pt,
)[Step 2: Configure optimization options (drivers/codecs) based on lab requirements.] \
#align(center)[
  #figure(
    image("assets/ubuntu-25-install-02-optimise.png", width: 88%),
    caption: [Optimization options screen.],
  )
]
#pagebreak()
#text(
  size: 12pt,
)[Step 3: Choose installation method in disk setup and select dual-boot option if required.] \
#align(center)[
  #figure(
    image("assets/ubuntu-25-install-03-disk-setup.png", width: 88%),
    caption: [Disk setup screen.],
  )
]

#v(0.6em)
#text(
  size: 12pt,
)[Step 4: Allocate partition space using the resize slider and finalize storage layout.] \
#align(center)[
  #figure(
    image("assets/ubuntu-25-install-04-partition-slider.png", width: 88%),
    caption: [Partition resize screen.],
  )
]
#pagebreak()
#text(
  size: 12pt,
)[Step 5: Create the primary user account and set login security options.] \
#align(center)[
  #figure(
    image("assets/ubuntu-25-install-06-create-account.png", width: 88%),
    caption: [Create account screen.],
  )
]

#v(0.6em)
#text(
  size: 12pt,
)[Step 6: Review the installer summary on the "Ready to install" screen before committing disk changes.] \
#align(center)[
  #figure(
    image("assets/ubuntu-25-install-05-ready-to-install.png", width: 88%),
    caption: [Ready-to-install summary.],
  )
]

#pagebreak()
#text(
  size: 12pt,
)[Step 7: After first boot, verify installed system details from Settings -> About.] \
#align(center)[
  #figure(
    image("assets/ubuntu-25-install-07-system-about.png", width: 88%),
    caption: [System About screen.],
  )
]

#v(0.8em)
#text(size: 14pt, weight: "bold")[Post-Installation Checklist:] \
- Verify internet connectivity and repository access.
- Update packages using your distribution package manager.
- Install developer essentials (compiler, editor, terminal tools).
- Take a snapshot/backup of the clean base system.

#v(0.8em)
#text(size: 14pt, weight: "bold")[Result:] \
Linux installation and initial configuration were completed successfully, and the environment is ready for subsequent practical exercises.
