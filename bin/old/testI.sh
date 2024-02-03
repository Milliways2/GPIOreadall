#!/bin/bash -e

# IMG_FILE="${STAGE_WORK_DIR}/${IMG_FILENAME}${IMG_SUFFIX}.img"
#
# unmount_image "${IMG_FILE}"
#
# rm -f "${IMG_FILE}"
#
# rm -rf "${ROOTFS_DIR}"
# mkdir -p "${ROOTFS_DIR}"

BOOT_SIZE="$((256 * 1024 * 1024))"
# TOTAL_SIZE=$(du --apparent-size -s "${EXPORT_ROOTFS_DIR}" --exclude var/cache/apt/archives --block-size=1 | cut -f 1)

ROUND_SIZE="$((4 * 1024 * 1024))"
ROUNDED_ROOT_SECTOR=$(((BOOT_SIZE + ROUND_SIZE) / ROUND_SIZE * ROUND_SIZE / 512 + 8192))
# IMG_SIZE=$(((BOOT_SIZE + TOTAL_SIZE + (800 * 1024 * 1024) + ROUND_SIZE - 1) / ROUND_SIZE * ROUND_SIZE))

echo $BOOT_SIZE $ROUNDED_ROOT_SECTOR $((BOOT_SIZE / 512))
