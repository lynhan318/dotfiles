/// <reference types="@vicinae/api">

/*
 * This file is auto-generated from the extension's manifest.
 * Do not modify manually. Instead, update the `package.json` file.
 */

type ExtensionPreferences = {
  /** Herdr Binary - Path to the herdr executable, or just its name to look it up on PATH. */
	"herdrPath": string;

	/** Terminal - Terminal used to host the session, invoked as <terminal> -e <herdr ...>. The other flags are ghostty-specific, so a different terminal needs src/lib/herdr.ts adjusted too. */
	"terminal": string;
}

declare type Preferences = ExtensionPreferences

declare namespace Preferences {
  /** Command: Search Herdr Sessions */
	export type HerdrSessions = ExtensionPreferences & {
		
	}

	/** Command: New Herdr Session */
	export type HerdrNewSession = ExtensionPreferences & {
		
	}
}

declare namespace Arguments {
  /** Command: Search Herdr Sessions */
	export type HerdrSessions = {
		
	}

	/** Command: New Herdr Session */
	export type HerdrNewSession = {
		
	}
}