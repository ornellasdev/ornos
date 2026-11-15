# OrnOS Plymouth theme (starter package)

Theme files for the Plymouth **script** plugin, branded in OrnOS violet/cyan.

## Important compatibility note
Plymouth's script API and available boot-progress signals can vary across Fedora/Plymouth versions. Treat this as a theme starter and test in a VM/snapshot before deploying. A custom Plymouth theme does not itself guarantee initramfs inclusion on bootc; bake the theme and dracut configuration into the image.

## Image files
- `images/logo.png`: transparent PNG logo asset (edit/replace with the final clean transparent logo)
- `images/spinner.png`: decorative pulse asset

## Fedora Atomic / bootc integration (image build)
Example Containerfile additions (adapt to your base image and version):

```Dockerfile
RUN rpm -q plymouth || dnf install -y plymouth plymouth-scripts && dnf clean all
COPY ornOS/ /usr/share/plymouth/themes/ornOS/
RUN printf '[Plymouth Theme]\\nName=OrnOS\\nDescription=OrnOS Neon\\nModuleName=script\\n\\n[script]\\nImageDir=/usr/share/plymouth/themes/ornOS/images\\nScriptFile=/usr/share/plymouth/themes/ornOS/ornOS.script\\n' > /usr/share/plymouth/themes/ornOS/ornOS.plymouth
RUN mkdir -p /etc/dracut.conf.d && echo 'add_dracutmodules+=\" plymouth \"' > /etc/dracut.conf.d/ornOS-plymouth.conf
RUN plymouth-set-default-theme ornOS
```

For boot splash, ensure your kernel command line includes `quiet splash` (and remove `rhgb` if you want Plymouth to own the splash). On bootc systems, make these changes in the image build rather than manually modifying the deployed root.

## Local test (mutable Fedora VM only)
```bash
sudo cp -r ornOS /usr/share/plymouth/themes/
sudo plymouth-set-default-theme ornOS
sudo dracut -f
```
Reboot only after confirming the theme is installed and the initramfs rebuilt.

## Package contents
- `ornOS/ornOS.plymouth`
- `ornOS/ornOS.script`
- `ornOS/images/logo.png`
- `ornOS/images/spinner.png`
