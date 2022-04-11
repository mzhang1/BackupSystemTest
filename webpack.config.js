const path = require('path');
const HtmlWebPackPlugin = require('html-webpack-plugin');
const webpack = require('webpack');

module.exports = {
	entry: "./src/index.js",
	output: {
		path: path.resolve(__dirname, './dist'),
		filename: 'bundle.js',
		clean: true
	},
	module: {
		rules: [
			{
				test: /\.css$/i,
				use: ['style-loader','css-loader']
			},
			{
				test: /\.(png|svg|jpg|jpeg|gif)$/i,
				type: 'asset/resource',
			},
			{
				test: /\.(woff|woff2|eot|ttf|otf)$/i,
				type: 'asset/resource',
			},
			{
				test: /\.(js|jsx)$/i,
				exclude: /node_modules/,
				use: {
					loader: "babel-loader"
				}
			}
		]
	},
	devtool: "source-map",
	plugins: [
		new HtmlWebPackPlugin({
			template: "./index.html"
		}),
		//These lines allows to avoid importing React/JQuery over and over
		new webpack.ProvidePlugin({
			$: 'jquery'
		})
	]
};