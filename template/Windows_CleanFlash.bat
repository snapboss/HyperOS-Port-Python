@echo off
cd %~dp0
set fastboot=bin\windows\fastboot.exe
if not exist %fastboot% echo %fastboot% not found. & pause & exit /B 1
echo Waiting for device...
set device=unknown
for /f "tokens=2" %%D in ('%fastboot% getvar product 2^>^&1 ^| findstr /l /b /c:"product:"') do set device=%%D
if "%device%" neq "duchamp" echo Compatible devices: duchamp & echo Your device: %device% & pause & exit /B 1

echo You are going to wipe your data and internal storage.
echo It will delete all your files and photos stored on internal storage.
set /p choice=Do you agree? (Y/N) 
if /i "%choice%" neq "y" exit /B 0

echo ##################################################################
echo Please wait. The device will reboot when installation is finished.
echo ##################################################################
%fastboot% set_active a
%fastboot% flash preloader_ab images\preloader_raw.img
%fastboot% flash apusys_ab images\apusys.img
%fastboot% flash audio_dsp_ab images\audio_dsp.img
%fastboot% flash ccu_ab images\ccu.img
%fastboot% flash connsys_bt_ab images\connsys_bt.img
%fastboot% flash connsys_gnss_ab images\connsys_gnss.img
%fastboot% flash connsys_wifi_ab images\connsys_wifi.img
%fastboot% flash dpm_ab images\dpm.img
%fastboot% flash dtbo_ab images\dtbo.img
%fastboot% flash gpueb_ab images\gpueb.img
%fastboot% flash gz_ab images\gz.img
%fastboot% flash lk_ab images\lk.img
%fastboot% flash logo_ab images\logo.img
%fastboot% flash mcf_ota_ab images\mcf_ota.img
%fastboot% flash mcupm_ab images\mcupm.img
%fastboot% flash modem_ab images\modem.img
%fastboot% flash mvpu_algo_ab images\mvpu_algo.img
%fastboot% flash pi_img_ab images\pi_img.img
%fastboot% flash scp_ab images\scp.img
%fastboot% flash spmfw_ab images\spmfw.img
%fastboot% flash sspm_ab images\sspm.img
%fastboot% flash tee_ab images\tee.img
%fastboot% flash vbmeta_ab images\vbmeta.img
%fastboot% flash vbmeta_system_ab images\vbmeta_system.img
%fastboot% flash vbmeta_vendor_ab images\vbmeta_vendor.img
%fastboot% flash vcp_ab images\vcp.img
%fastboot% flash boot_ab images\boot.img
%fastboot% flash init_boot_ab images\init_boot.img
%fastboot% flash vendor_boot_ab images\vendor_boot.img
%fastboot% flash super images\super.img
%fastboot% erase metadata
%fastboot% erase userdata
%fastboot% erase expdb
%fastboot% erase frp
%fastboot% oem cdms
%fastboot% reboot
