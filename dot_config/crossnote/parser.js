({
	// Please visit the URL below for more information:
	// https://shd101wyy.github.io/markdown-preview-enhanced/#/extend-parser

	onWillParseMarkdown: async (markdown) => markdown,

	onDidParseMarkdown: async (html) => html,
});
