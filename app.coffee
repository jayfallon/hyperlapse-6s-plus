# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: "Hyperlapse"
	author: "Jay Fallon"
	twitter: "jayfallon"
	description: "Intro for Instagram's Hyperlapse"


### IMPORTS ###

# importing howler.js for playing audio with the web audio api
# https://github.com/goldfire.howler.js
howler = require('myModule').howler

### MUSIC ###

# the music in 4 looping tracks
music_1 = new Howl
	urls: ["audio/music_1.wav"]
	loop: yes
music_2 = new Howl
	urls: ["audio/music_2.wav"]
	loop: yes
music_3 = new Howl
	urls: ["audio/music_3.wav"]
	loop: yes
music_4 = new Howl
	urls: ["audio/music_4.wav"]
	loop: yes

### PAGE COMPONENT ###
page = new PageComponent
	width: Screen.width
	height: Screen.height
	scrollVertical: no
	x: Screen.width
	
#diasble overdrag
page.content.draggable.overdrag = no

### PAGE ONE ###
page_1 = new Layer
	backgroundColor: "transparent"
	width: Screen.width, height: Screen.height
page.addPage page_1	
	
# Page 1 content	
	
# Bridge Video
video_1_Bridge = new VideoLayer
	superLayer: page_1
	backgroundColor: "transparent"
	width: Screen.width, height: Screen.height
	video: "videos/Video_1_Bridge.mp4"
	
video_1_Bridge.player.loop = yes

# create amazing text
create_amazing_handheld = new Layer
	superLayer: page_1
	width: 512*2, height: 122*2
	image: "images/Create_amazing_handheld.png"
	x: 64*2, y: 83*2
	opacity: 0.8
	
# swipe to continue label	
swipe_to_continue = new Layer
	superLayer: page_1
	width: 400*2, height: 115*2,
	image: "images/swipe_to_continue.png"
	x: 120*2, y: 821*2
	originY: 1
	scale: 0.5
	opacity: 0
	
# Show swipe to continue
showSwipeToContinue = new Animation
	layer: swipe_to_continue
	properties:
		scale: 1
		opacity: 1
	curve: "spring(300,20,0)"
	
# Hide swipe to continue
hideSwipToContinue = new Animation
	properties:
		scale: 0.5
		opacity: 0
	curve: "spring(300,20,0)"
	
# trigger Hide swipe when Show swipe ends
showSwipeToContinue.on Events.AnimationEnd,
showSwipeToContinue.start

# temp test
page_1.on Events.Click, ->
	showSwipeToContinue.start()	

### PAGE TWO ###
page_2 = new Layer
	backgroundColor: "transparent"
	width: Screen.width, height: Screen.height
page.addPage page_2	
	
# Clouds video
video_2_Clouds = new VideoLayer
	superLayer: page_2
	backgroundColor: "transparent"
	width: Screen.width, height: Screen.height
	video: "videos/Video_2_Clouds.mp4"
	
video_2_Clouds.player.loop = yes

# hyperlapse text
hyperlapse_stabilizes_your_video = new Layer
	superLayer: page_2
	width: 534*2, height: 104*2
	image: "images/hyperlapse_stabilizes_your_video.png"
	x: 52*2, y: 95*2
	opacity: 0.8

### PAGE THREE ###
page_3 = new Layer
	backgroundColor: "transparent"
	width: Screen.width, height: Screen.height
page.addPage page_3	
	
# Train video
video_3_train = new VideoLayer
	superLayer: page_3
	backgroundColor: "transparent"
	width: Screen.width, height: Screen.height
	video: "videos/Video_3_train.mp4"
	
video_3_train.player.loop = yes

# share your hyperlapse text
share_your_hyperlapses_with = new Layer
	superLayer: page_3
	width: 539*2, height: 104*2
	image: "images/Share_your_hyperlapses_with.png"
	x: 50*2, y: 95*2
	opacity: 0.8

### PAGE FOUR ###
page_4 = new Layer
	backgroundColor: "transparent"
	width: Screen.width, height: Screen.height
page.addPage page_4	
	
# People video
video_4_people = new VideoLayer
	superLayer: page_4
	backgroundColor: "transparent"
	width: Screen.width, height: Screen.height
	video: "videos/Video_4_people.mp4"
	
video_4_people.player.loop = yes

# get started text
get_started_by_letting_Hyperlapse = new Layer
	superLayer: page_4
	width: 530*2, height: 105*2
	image: "images/get_started_by_letting_Hyperlapse.png"
	x: 56*2, y: 95*2
	opcatiy: 0.8
	
# allow access prompt
allow_access = new Layer
	superLayer: page_4
	width: 440*2, height: 100*2
	image: "images/allow_access.png"
	x: 100*2, y: 249*2

### SPLASH AND INTERACTION ###
splash = new Layer
	width: Screen.width, height: Screen.height
	image: "images/Splash_screen.png"
	
wheel = new Layer
	superLayer: splash
	width: 248*2, height: 248*2
	image: "images/spinning_wheel.png"
	y: 250*2
wheel.centerX()

# start spinning wheel after 2 seconds
Utils.delay 2.0, ->
	wheel.animate
		properties:
			rotation: 360*15
		time: 5
		curve: "ease-in"
		
	#slide to the videos after 3.3 seconds or more
	splash.animate
		properties: 
			x: -Screen.width
		curve: "spring(250,25,0)"
		delay: 3.3
	page.animate
		properties: 
			x: 0
		curve: "spring(250,25,0)"
		delay: 3.3
		
	# start playing the videos
	Utils.delay 5.2, ->
		video_1_Bridge.player.play()
		video_2_Clouds.player.play()
		video_3_train.player.play()
		# Start the music
		music_1.play()
		music_2.play().mute()
		music_3.play().mute()
		music_4.play().mute()
		
# make swipe appear
user_has_swiped = no

# User hasn't swiped +- ten seconds of first video?
# -> tell them to swipe
Utils.delay 15.0, ->
	if user_has_swiped is no
		showSwipeToContinue.start()
		
page.on "change:currentPage", ->
	user_has_swiped = yes
	page_index = page.horizontalPageIndex page.currentPage
	
	switch page_index
		when 0
			music_2.mute()
		when 1
			music_2.unmute()
			music_3.mute()
		when 2
			music_3.unmute()
			music_4.mute()
		when 3
			music_4.unmute()
			video_4_people.player.play()
			
	for dot_filled in allSolidDots
		dot_filled.states.switch "default"
	
	for i in [0..page_index]
		allSolidDots[i].states.switch "active"
		
page.on Events.DoubleClick, ->
	music_1.pause()
	music_2.pause()
	music_3.pause()
	music_4.pause()

### PAGE INDICATORS ###

# array for indicators
allSolidDots = []	

for i in [0..3]
	#empty page indicators
	dot_hollow = new Layer
		superLayer: page
		width: 16*2, height: 16*2
		image: "images/dot_hollow.png"
		x: (264*2) + i*64, y: 1021*2
	# filled page indicators
	dot_filled = new Layer
		superLayer: page
		width: 16*2, height: 16*2
		image: "images/dot_filled.png"
		x: (264*2) + i*64, y: 1021*2
		opacity: 0
	# filled states
	dot_filled.states.add
		active:
			opacity: 1
	# filled animation
	dot_filled.states.animationOptions = time: 0.5
	# push solid dots to array
	allSolidDots.push dot_filled
	
# set first indicator to active
allSolidDots[0].states.switch "active"
