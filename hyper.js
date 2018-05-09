module.exports = {
	config: {
		fontSize: 12,
		fontFamily: 'SFMono-Regular, IBM Plex Mono, Inconsolata, Consolas, monospace',
		lineHeight: 1.2,
		cursorShape: 'BLOCK',
		cursorBlink: true,
		bell: false,
		shell: '/usr/local/bin/zsh',
		modifierKeys: {
			altIsMeta: true
		},
		updateChannel: 'canary'
	},
	plugins: [
		'hyper-search',
		'hyper-snazzy',
		'hypercwd',
		'hyperterm-paste',
		'hyperterm-tabs#next'
	]
};
