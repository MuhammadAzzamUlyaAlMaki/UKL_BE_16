/*
  Warnings:

  - The primary key for the `borrowrecord` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `borrowDate` on the `borrowrecord` table. All the data in the column will be lost.
  - You are about to drop the column `id` on the `borrowrecord` table. All the data in the column will be lost.
  - You are about to drop the column `itemId` on the `borrowrecord` table. All the data in the column will be lost.
  - You are about to drop the column `returnDate` on the `borrowrecord` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `borrowrecord` table. All the data in the column will be lost.
  - You are about to drop the `item` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `borrow_date` to the `BorrowRecord` table without a default value. This is not possible if the table is not empty.
  - Added the required column `borrow_id` to the `BorrowRecord` table without a default value. This is not possible if the table is not empty.
  - Added the required column `item_id` to the `BorrowRecord` table without a default value. This is not possible if the table is not empty.
  - Added the required column `return_date` to the `BorrowRecord` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `BorrowRecord` table without a default value. This is not possible if the table is not empty.
  - Added the required column `role` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `borrowrecord` DROP FOREIGN KEY `BorrowRecord_itemId_fkey`;

-- DropForeignKey
ALTER TABLE `borrowrecord` DROP FOREIGN KEY `BorrowRecord_userId_fkey`;

-- AlterTable
ALTER TABLE `borrowrecord` DROP PRIMARY KEY,
    DROP COLUMN `borrowDate`,
    DROP COLUMN `id`,
    DROP COLUMN `itemId`,
    DROP COLUMN `returnDate`,
    DROP COLUMN `userId`,
    ADD COLUMN `borrow_date` DATETIME(3) NOT NULL,
    ADD COLUMN `borrow_id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD COLUMN `item_id` INTEGER NOT NULL,
    ADD COLUMN `return_date` DATETIME(3) NOT NULL,
    ADD COLUMN `user_id` INTEGER NOT NULL,
    ADD PRIMARY KEY (`borrow_id`);

-- AlterTable
ALTER TABLE `user` ADD COLUMN `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `role` ENUM('ADMIN', 'USER') NOT NULL,
    ADD COLUMN `updated_at` DATETIME(3) NOT NULL;

-- DropTable
DROP TABLE `item`;

-- CreateTable
CREATE TABLE `Items` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `category` VARCHAR(191) NOT NULL,
    `location` VARCHAR(191) NOT NULL,
    `quantity` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ReturnRecord` (
    `return_id` INTEGER NOT NULL AUTO_INCREMENT,
    `borrow_id` INTEGER NOT NULL,
    `user_id` INTEGER NOT NULL,
    `item_id` INTEGER NOT NULL,
    `actual_return_date` DATETIME(3) NOT NULL,

    UNIQUE INDEX `ReturnRecord_borrow_id_key`(`borrow_id`),
    PRIMARY KEY (`return_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `BorrowRecord` ADD CONSTRAINT `BorrowRecord_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `BorrowRecord` ADD CONSTRAINT `BorrowRecord_item_id_fkey` FOREIGN KEY (`item_id`) REFERENCES `Items`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ReturnRecord` ADD CONSTRAINT `ReturnRecord_borrow_id_fkey` FOREIGN KEY (`borrow_id`) REFERENCES `BorrowRecord`(`borrow_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ReturnRecord` ADD CONSTRAINT `ReturnRecord_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ReturnRecord` ADD CONSTRAINT `ReturnRecord_item_id_fkey` FOREIGN KEY (`item_id`) REFERENCES `Items`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
