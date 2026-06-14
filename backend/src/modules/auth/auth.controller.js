import { HttpResponse } from '../../common/dtos/index.js';
import { authService } from './auth.service.js';

export const authController = {
	async register(req, res, next) {
		try {
			const data = await authService.register(req.body);
			return new HttpResponse(res).created(data);
		} catch (error) {
			next(error);
		}
	},

	async login(req, res, next) {
		try {
			const data = await authService.login(req.body);
			return new HttpResponse(res).success(data);
		} catch (error) {
			next(error);
		}
	},

	async verifyEmail(req, res, next) {
		try {
			const data = await authService.verifyEmail(req.body);
			return new HttpResponse(res).success(data);
		} catch (error) {
			next(error);
		}
	},

	// Dành cho GET request khi click từ email
	async verifyEmailGet(req, res, next) {
		try {
			const token = req.query.token;
			if (!token) {
				return res.status(400).send(`<h2>Lỗi: Không tìm thấy token xác thực.</h2>`);
			}
			await authService.verifyEmail({ token });
			return res.send(`
				<div style="font-family: sans-serif; text-align: center; margin-top: 50px;">
					<h2 style="color: #28a745;">Xác thực tài khoản thành công! 🎉</h2>
					<p>Bây giờ bạn đã có thể quay lại ứng dụng để đăng nhập.</p>
				</div>
			`);
		} catch (error) {
			return res.status(400).send(`
				<div style="font-family: sans-serif; text-align: center; margin-top: 50px;">
					<h2 style="color: #dc3545;">Xác thực thất bại ❌</h2>
					<p>${error.message}</p>
				</div>
			`);
		}
	},
};
