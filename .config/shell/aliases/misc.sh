if [ -d "$HOME/Android/Sdk" ]; then
  alias start-android-emulator="\$HOME/Android/Sdk/emulator/emulator -avd Pixel_4_API_30 -qemu -enable-kvm"
fi
