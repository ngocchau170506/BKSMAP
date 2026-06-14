/*
  Warnings:

  - You are about to drop the column `full_name` on the `Owner` table. All the data in the column will be lost.
  - You are about to drop the column `full_name` on the `User` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[email]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `username` to the `Owner` table without a default value. This is not possible if the table is not empty.
  - Added the required column `email` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "User_username_key";

-- AlterTable
ALTER TABLE "Owner" DROP COLUMN "full_name",
ADD COLUMN     "username" VARCHAR(100) NOT NULL;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "full_name",
ADD COLUMN     "email" VARCHAR(50) NOT NULL,
ALTER COLUMN "username" DROP NOT NULL,
ALTER COLUMN "username" SET DATA TYPE VARCHAR(100);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
