module SongsHelper
    def display_song(song, artist)
        song.nil? ? link_to("Add Artist", artist_songs_path(artist)) : link_to(song.artist_name, artist_path(song.artist))
      end
end
