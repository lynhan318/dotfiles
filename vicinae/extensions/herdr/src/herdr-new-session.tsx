import { Action, ActionPanel, Form, Icon } from "@vicinae/api";
import { useEffect, useState } from "react";
import {
	type Session,
	listSessions,
	openSession,
	preferences,
	validateSessionName,
} from "./lib/herdr";

export default function Command() {
	const { herdr, term } = preferences();

	const [existing, setExisting] = useState<Session[]>([]);
	const [isLoading, setIsLoading] = useState(true);
	const [name, setName] = useState("");
	const [nameError, setNameError] = useState<string | undefined>();

	// Loaded only to reject names that are already taken — the form stays usable
	// if the listing fails, in which case herdr just attaches to the existing
	// session instead of creating one.
	useEffect(() => {
		listSessions(herdr)
			.then(setExisting)
			.catch(() => setExisting([]))
			.finally(() => setIsLoading(false));
	}, [herdr]);

	const submit = async (values: Form.Values) => {
		const raw = String(values.name ?? "");
		const problem = validateSessionName(raw, existing);
		if (problem) {
			setNameError(problem);
			return false;
		}

		const picked = Array.isArray(values.directory) ? values.directory[0] : undefined;
		const directory = picked === undefined ? undefined : String(picked);
		await openSession({ name: raw.trim(), default: false }, { directory });
	};

	return (
		<Form
			isLoading={isLoading}
			navigationTitle="New Herdr Session"
			actions={
				<ActionPanel>
					<Action.SubmitForm
						title={`Create and Open in ${term}`}
						icon={Icon.Plus}
						onSubmit={submit}
					/>
					<Action.Push
						title="Search Existing Sessions"
						icon={Icon.MagnifyingGlass}
						shortcut="open"
						target={<SessionHint sessions={existing} />}
					/>
				</ActionPanel>
			}
		>
			<Form.TextField
				id="name"
				title="Name"
				placeholder="my-project"
				// No angle brackets in info text — Vicinae strips them as markup.
				info="Becomes a directory under ~/.config/herdr/sessions, and is passed to herdr as the --session argument."
				autoFocus
				value={name}
				error={nameError}
				onChange={(next) => {
					setName(next);
					if (nameError) setNameError(undefined);
				}}
				onBlur={() => setNameError(validateSessionName(name, existing))}
			/>
			<Form.FilePicker
				id="directory"
				title="Working Directory"
				info="Optional. The terminal starts here, so the session's panes open in this directory."
				allowMultipleSelection={false}
				canChooseDirectories
				canChooseFiles={false}
			/>
			<Form.Description
				title="Existing"
				text={
					existing.length
						? existing.map((session) => session.name).join(", ")
						: "No sessions yet"
				}
			/>
		</Form>
	);
}

/** Read-only peek at what already exists, reachable from the form. */
function SessionHint({ sessions }: { sessions: Session[] }) {
	return (
		<Form navigationTitle="Existing Sessions">
			<Form.Description
				title="Sessions"
				text={
					sessions.length
						? sessions
								.map(
									(session) =>
										`${session.name} — ${session.running ? "running" : "stopped"} — ${session.session_dir}`,
								)
								.join("\n")
						: "No sessions yet"
				}
			/>
		</Form>
	);
}
