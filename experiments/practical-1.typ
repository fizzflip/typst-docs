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
  Installing and configuring Linux is a foundational system administration task. The process generally involves creating bootable installation media, selecting installation targets (bare metal or virtual machine), partitioning storage, choosing required packages, and configuring user/network settings. Post-installation configuration ensures the system is usable for development and lab activities.
]

#text(size: 14pt, weight: "bold")[Installation Walkthrough:] \
#text(size: 12pt)[Step 1: Boot from installation media and choose the install option.] \
#align(center)[
  #figure(
    image("assets/install-step-select.png", width: 88%),
    caption: [Ubuntu 24.04 installer start screen ("Try or Install Ubuntu").],
  )
]

#v(0.6em)
#text(size: 12pt)[Step 2: Configure installation type and partitioning choices.] \
#align(center)[
  #figure(
    image("assets/install-step-partition.png", width: 88%),
    caption: [Ubuntu 24.04 disk setup and partitioning screen.],
  )
]

#v(0.6em)
#text(size: 12pt)[Step 3: Let the installer complete package deployment and setup.] \
#align(center)[
  #figure(
    image("assets/install-step-progress.png", width: 88%),
    caption: [Ubuntu 24.04 installation progress before reboot.],
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
