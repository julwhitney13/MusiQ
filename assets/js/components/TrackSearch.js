import React, {Component } from 'react';
import { form, FormGroup, FormControl, InputGroup, Glyphicon, ControlLabel, Button} from 'react-bootstrap';
import axios from 'axios';

export default class TrackSearch extends Component {
    constructor(props) {
        super(props)
        this.state = {
          songsearch: false,
          songquery: '',
          artistsearch: false,
          artistquery: '',
          albumsearch: false,
          albumquery: '',
        }
    }
    submitForm(e) {
        e.preventDefault()
        var params = []
        if (songsearch) {
            params.push({"q": this.state.songquery, "type": "track"})
        }
        if (artistsearch) {
            params.push({"q": this.state.artistquery, "type": "artist"})
        }
        if (albumquery) {
            params.push({"q": this.state.albumquery, "type": "album"})
        }

        axios.get('/search', params)
            .then(res => { console.log(JSON.stringify(res))
        });

    }

    render() {
        return (
            <form onSubmit={this.submitForm}>
                <ControlLabel>Search by song</ControlLabel>
                <FormGroup>
                  <InputGroup>
                    <InputGroup.Addon>
                      <input type="checkbox" name="songsearch" checked={this.state.songsearch} />
                    </InputGroup.Addon>
                    <FormControl type="text" name="songquery" value={this.state.songquery}  placeholder="Enter a song name..."/>
                  </InputGroup>
                </FormGroup>
                <ControlLabel>Search by artist</ControlLabel>
                <FormGroup>
                  <InputGroup>
                    <InputGroup.Addon>
                      <input type="checkbox" name="artistsearch" checked={this.state.artistsearch} />
                    </InputGroup.Addon>
                    <FormControl type="text" name="artistquery" value={this.state.artistquery} placeholder="Enter an artist..."/>
                  </InputGroup>
                </FormGroup>
                <ControlLabel>Search by album</ControlLabel>
                <FormGroup>
                  <InputGroup>
                    <InputGroup.Addon>
                      <input type="checkbox" name="albumsearch" checked={this.state.albumsearch} />
                    </InputGroup.Addon>
                    <FormControl type="text" name="albumquery" value={this.state.albumquery}  placeholder="Enter an album..."/>
                  </InputGroup>
                </FormGroup>
                <Button type="submit">
                  Search
                </Button>
            </form>
          )
      }
}
