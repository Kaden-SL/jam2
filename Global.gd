extends Node

var prevMissedNotes = 0
var prevBossHealth = 0

var defaultmissedNotes = 50
var deafultbossHealth = 100

var missedNotes = defaultmissedNotes
var bossHealth = deafultbossHealth
var current_universe = "R"
var note_universe = "R"

var isTouchingNote = false;
var ActiveSongPlayer = "";
var isHalfwayThroughSong = false;
var sceneTiming = false;

var currentLevel = 0
