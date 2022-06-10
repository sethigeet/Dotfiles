if [ -d "$HOME/Android/Sdk" ]; then
  alias start-android-emulator="\$HOME/Android/Sdk/emulator/emulator -avd Pixel_5_API_31 -qemu -enable-kvm"
fi
