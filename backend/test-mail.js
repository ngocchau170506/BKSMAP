import dotenv from 'dotenv';
dotenv.config();

import nodemailer from 'nodemailer';

const transporter = nodemailer.createTransport({
	host: process.env.SMTP_HOST || 'smtp.gmail.com',
	port: process.env.SMTP_PORT || 587,
	secure: process.env.SMTP_SECURE === 'true',
	auth: {
		user: process.env.SMTP_USER,
		pass: process.env.SMTP_PASS,
	},
});

async function main() {
  try {
    console.log('Sending email...');
    let info = await transporter.sendMail({
      from: `"Test User" <${process.env.SMTP_USER}>`,
      to: process.env.SMTP_USER, // send to self
      subject: "Hello ✔",
      text: "Hello world?",
    });
    console.log("Message sent: %s", info.messageId);
  } catch (err) {
    console.error("Error sending mail:", err);
  }
}
main();
