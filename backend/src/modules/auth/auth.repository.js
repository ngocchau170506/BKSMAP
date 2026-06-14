import prisma from '../../config/database.js';

export const authRepository = {
	async findUserByEmail(email) {
		return await prisma.user.findUnique({
			// Prisma generate model là User (PascalCase)
			where: { email },
		});
	},

	async createUser(data) {
		return await prisma.user.create({
			data: {
				email: data.email,
				passwordHash: data.passwordHash,
				userName: data.userName,
				avatar: data.avatar,
				isVerified: false,
				verifyToken: data.verifyToken,
			},
		});
	},

	async findUserByVerifyToken(token) {
		return await prisma.user.findFirst({
			where: { verifyToken: token },
		});
	},

	async verifyUser(userId) {
		return await prisma.user.update({
			where: { id: userId },
			data: {
				isVerified: true,
				verifyToken: null,
				tokenExpires: null,
			},
		});
	},
};
