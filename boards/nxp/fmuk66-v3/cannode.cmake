

# UAVCAN boot loadable Module ID
set(uavcanblid_sw_version_major 0)
set(uavcanblid_sw_version_minor 1)
add_definitions(
	-DAPP_VERSION_MAJOR=${uavcanblid_sw_version_major}
	-DAPP_VERSION_MINOR=${uavcanblid_sw_version_minor}
)

# Bring in common uavcan hardware identity definitions
include(px4_git)
px4_add_git_submodule(TARGET git_uavcan_board_ident PATH "cmake/configs/uavcan_board_ident")

set(uavcanblid_hw_version_major 1)
set(uavcanblid_hw_version_minor 0)
set(uavcanblid_name "\"org.pixhawk.nxp_fmuk66-v3_cannode\"")

add_definitions(
	-DHW_UAVCAN_NAME=${uavcanblid_name}
	-DHW_VERSION_MAJOR=${uavcanblid_hw_version_major}
	-DHW_VERSION_MINOR=${uavcanblid_hw_version_minor}
)

px4_add_board(
	PLATFORM nuttx
	VENDOR nxp
	MODEL fmuk66-v3
	LABEL cannode
	TOOLCHAIN arm-none-eabi
	ARCHITECTURE cortex-m4
	ROMFSROOT px4fmu_common
	UAVCAN_INTERFACES 2
	SERIAL_PORTS
		GPS1:/dev/ttyS3
		TEL1:/dev/ttyS4
		TEL2:/dev/ttyS1
	DRIVERS
		adc
		barometer # all available barometer drivers
		barometer/mpl3115a2
		bootloaders
		differential_pressure # all available differential pressure drivers
		distance_sensor # all available distance sensor drivers
		#dshot
		gps
		#imu # all available imu drivers
		imu/fxas21002c
		imu/fxos8701cq
		lights/rgbled
		lights/rgbled_ncp5623c
		lights/rgbled_pwm
		magnetometer # all available magnetometer drivers
		#optical_flow # all available optical flow drivers
		optical_flow/px4flow
		power_monitor/ina226
		#px4fmu
		#safety_button
		#tone_alarm
		uavcannode
	MODULES
		#ekf2
		#load_mon
		#sensors
		#temperature_compensation
	SYSTEMCMDS
		#bl_update
		#dmesg
		#dumpfile
		#esc_calib
		#hardfault_log
		i2cdetect
		#led_control
		#mixer
		#motor_ramp
		#motor_test
		mtd
		#nshterm
		param
		perf
		#pwm
		reboot
		#reflect
		#sd_bench
		#shutdown
		top
		#topic_listener
		#tune_control
		ver
		work_queue
)

include(px4_make_uavcan_bootloader)
px4_make_uavcan_bootloadable(
	BOARD ${PX4_BOARD}
	BIN ${PX4_BINARY_DIR}/${PX4_BOARD}.bin
	HWNAME ${uavcanblid_name}
	HW_MAJOR ${uavcanblid_hw_version_major}
	HW_MINOR ${uavcanblid_hw_version_minor}
	SW_MAJOR ${uavcanblid_sw_version_major}
	SW_MINOR ${uavcanblid_sw_version_minor}
)
