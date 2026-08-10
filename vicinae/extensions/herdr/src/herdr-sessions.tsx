import {
	Action,
	ActionPanel,
	Clipboard,
	Icon,
	List,
} from "@vicinae/api";
import { useCallback, useEffect, useState } from "react";
import NewSession from "./herdr-new-session";
import {
	type Session,
	attachCommand,
	listSessions,
	openSession,
	preferences,
} from "./lib/herdr";

export default function Command() {
	const { herdr, term } = preferences();

	const [sessions, setSessions] = useState<Session[]>([]);
	const [isLoading, setIsLoading] = useState(true);
	const [error, setError] = useState<string | undefined>();

	const load = useCallback(async () => {
		setIsLoading(true);
		try {
			setSessions(await listSessions(herdr));
			setError(undefined);
		} catch (cause) {
			setError(cause instanceof Error ? cause.message : String(cause));
			setSessions([]);
		} finally {
			setIsLoading(false);
		}
	}, [herdr]);

	useEffect(() => {
		void load();
	}, [load]);

	const newSessionAction = (
		<Action.Push
			title="New Session"
			icon={Icon.Plus}
			shortcut="new"
			target={<NewSession />}
		/>
	);

	const reloadAction = (
		<Action
			title="Reload"
			icon={Icon.ArrowClockwise}
			shortcut="refresh"
			onAction={() => void load()}
		/>
	);

	return (
		<List
			isLoading={isLoading}
			searchBarPlaceholder="Search Herdr sessions..."
			actions={
				<ActionPanel>
					{newSessionAction}
					{reloadAction}
				</ActionPanel>
			}
		>
			{error ? (
				<List.EmptyView
					icon={Icon.Exclamationmark}
					title="Could not list sessions"
					description={error}
				/>
			) : (
				sessions.map((session) => (
					<List.Item
						key={session.name}
						id={session.name}
						title={session.name}
						subtitle={session.session_dir}
						icon={Icon.Code}
						keywords={[session.session_dir, session.running ? "running" : "stopped"]}
						accessories={[
							// Spread, not a ternary yielding {} — an empty accessory
							// still renders as a blank chip.
							...(session.default ? [{ tag: "default" }] : []),
							{ tag: session.running ? "running" : "stopped" },
						]}
						actions={
							<ActionPanel>
								<Action
									title={`Open in ${term}`}
									icon={Icon.Code}
									onAction={() => void openSession(session)}
								/>
								{newSessionAction}
								<Action
									title="Copy Session Name"
									icon={Icon.CopyClipboard}
									shortcut="copy-name"
									onAction={() => void Clipboard.copy(session.name)}
								/>
								<Action
									title="Copy Attach Command"
									icon={Icon.CopyClipboard}
									shortcut="copy"
									onAction={() => void Clipboard.copy(attachCommand(herdr, session))}
								/>
								<Action
									title="Copy Session Directory"
									icon={Icon.Folder}
									shortcut="copy-path"
									onAction={() => void Clipboard.copy(session.session_dir)}
								/>
								{reloadAction}
							</ActionPanel>
						}
					/>
				))
			)}
		</List>
	);
}
