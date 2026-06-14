/*
  Warnings:

  - You are about to drop the column `phone_number` on the `Owner` table. All the data in the column will be lost.
  - You are about to drop the column `username` on the `Owner` table. All the data in the column will be lost.
  - You are about to drop the column `created_at` on the `Room` table. All the data in the column will be lost.
  - You are about to drop the column `created_by` on the `Room` table. All the data in the column will be lost.
  - You are about to drop the column `distance_to_bk` on the `Room` table. All the data in the column will be lost.
  - You are about to drop the column `electricity_price` on the `Room` table. All the data in the column will be lost.
  - You are about to drop the column `owner_id` on the `Room` table. All the data in the column will be lost.
  - You are about to drop the column `shared_owner` on the `Room` table. All the data in the column will be lost.
  - You are about to drop the column `updated_at` on the `Room` table. All the data in the column will be lost.
  - You are about to drop the column `water_price` on the `Room` table. All the data in the column will be lost.
  - The primary key for the `RoomFeature` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `feature_id` on the `RoomFeature` table. All the data in the column will be lost.
  - You are about to drop the column `room_id` on the `RoomFeature` table. All the data in the column will be lost.
  - You are about to drop the column `created_at` on the `RoomImage` table. All the data in the column will be lost.
  - You are about to drop the column `display_order` on the `RoomImage` table. All the data in the column will be lost.
  - You are about to drop the column `image_url` on the `RoomImage` table. All the data in the column will be lost.
  - You are about to drop the column `room_id` on the `RoomImage` table. All the data in the column will be lost.
  - You are about to drop the column `created_at` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `password_hash` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `updated_at` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `username` on the `User` table. All the data in the column will be lost.
  - Added the required column `phoneNumber` to the `Owner` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userName` to the `Owner` table without a default value. This is not possible if the table is not empty.
  - Added the required column `createdBy` to the `Room` table without a default value. This is not possible if the table is not empty.
  - Added the required column `ownerId` to the `Room` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Room` table without a default value. This is not possible if the table is not empty.
  - Added the required column `featureId` to the `RoomFeature` table without a default value. This is not possible if the table is not empty.
  - Added the required column `roomId` to the `RoomFeature` table without a default value. This is not possible if the table is not empty.
  - Added the required column `imageUrl` to the `RoomImage` table without a default value. This is not possible if the table is not empty.
  - Added the required column `roomId` to the `RoomImage` table without a default value. This is not possible if the table is not empty.
  - Added the required column `passwordHash` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Room" DROP CONSTRAINT "Room_created_by_fkey";

-- DropForeignKey
ALTER TABLE "Room" DROP CONSTRAINT "Room_owner_id_fkey";

-- DropForeignKey
ALTER TABLE "RoomFeature" DROP CONSTRAINT "RoomFeature_feature_id_fkey";

-- DropForeignKey
ALTER TABLE "RoomFeature" DROP CONSTRAINT "RoomFeature_room_id_fkey";

-- DropForeignKey
ALTER TABLE "RoomImage" DROP CONSTRAINT "RoomImage_room_id_fkey";

-- AlterTable
ALTER TABLE "Owner" DROP COLUMN "phone_number",
DROP COLUMN "username",
ADD COLUMN     "phoneNumber" VARCHAR(20) NOT NULL,
ADD COLUMN     "userName" VARCHAR(100) NOT NULL;

-- AlterTable
ALTER TABLE "Room" DROP COLUMN "created_at",
DROP COLUMN "created_by",
DROP COLUMN "distance_to_bk",
DROP COLUMN "electricity_price",
DROP COLUMN "owner_id",
DROP COLUMN "shared_owner",
DROP COLUMN "updated_at",
DROP COLUMN "water_price",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "createdBy" UUID NOT NULL,
ADD COLUMN     "distanceToBk" DECIMAL(5,2),
ADD COLUMN     "electricityPrice" INTEGER,
ADD COLUMN     "ownerId" UUID NOT NULL,
ADD COLUMN     "sharedOwner" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "waterPrice" INTEGER;

-- AlterTable
ALTER TABLE "RoomFeature" DROP CONSTRAINT "RoomFeature_pkey",
DROP COLUMN "feature_id",
DROP COLUMN "room_id",
ADD COLUMN     "featureId" UUID NOT NULL,
ADD COLUMN     "roomId" UUID NOT NULL,
ADD CONSTRAINT "RoomFeature_pkey" PRIMARY KEY ("roomId", "featureId");

-- AlterTable
ALTER TABLE "RoomImage" DROP COLUMN "created_at",
DROP COLUMN "display_order",
DROP COLUMN "image_url",
DROP COLUMN "room_id",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "displayOrder" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "imageUrl" TEXT NOT NULL,
ADD COLUMN     "roomId" UUID NOT NULL;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "created_at",
DROP COLUMN "password_hash",
DROP COLUMN "updated_at",
DROP COLUMN "username",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "passwordHash" VARCHAR(255) NOT NULL,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "userName" VARCHAR(100);

-- AddForeignKey
ALTER TABLE "Room" ADD CONSTRAINT "Room_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Room" ADD CONSTRAINT "Room_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "Owner"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RoomFeature" ADD CONSTRAINT "RoomFeature_roomId_fkey" FOREIGN KEY ("roomId") REFERENCES "Room"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RoomFeature" ADD CONSTRAINT "RoomFeature_featureId_fkey" FOREIGN KEY ("featureId") REFERENCES "Feature"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RoomImage" ADD CONSTRAINT "RoomImage_roomId_fkey" FOREIGN KEY ("roomId") REFERENCES "Room"("id") ON DELETE CASCADE ON UPDATE CASCADE;
