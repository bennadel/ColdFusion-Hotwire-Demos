component
	output = false
	hint = "I provide simple note taking functionality."
	{

	/**
	* I return the initialized note service.
	*/
	public void function init() {

		// All notes will be indexed based on their ID. Since we're using an ordered
		// struct, the orders of the keys will match the order of note creation.
		variables.notesIndex = [:];

	}

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I create a new note with the given text. The ID of the new note is returned.
	*/
	public string function createNote( required string text ) {

		if ( ! text.len() ) {

			throw(
				type = "App.Model.Note.Text.Empty",
				message = "Note text is empty."
			);
			
		}

		if ( text != text.trim() ) {

			throw(
				type = "App.Model.Note.Text.SuspiciousWhiteSpace",
				message = "Note text not trimmed properly."
			);

		}

		var note = {
			id: createUniqueId(),
			text: text,
			createdAt: now()
		}

		variables.notesIndex[ note.id ] = note;

		return( note.id );

	}


	/**
	* I delete all of the current notes.
	*/
	public void function deleteAllNotes() {

		variables.notesIndex = [:];

	}


	/**
	* I delete the note with the given ID.
	*/
	public void function deleteNote( required string id ) {

		variables.notesIndex.delete( id );

	}


	/**
	* I return the note with the given ID.
	*/
	public struct function getNote( required string id ) {

		return( duplicate( variables.notesIndex[ id ] ) );

	}


	/**
	* I return the collection of notes.
	*/
	public array function getNotes() {

		var notes = variables.notesIndex
			.keyArray()
			.map(
				( id ) => {

					return( getNote( id ) );

				}
			)
		;

		return( notes );

	}

}
