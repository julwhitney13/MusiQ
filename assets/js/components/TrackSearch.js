import React, {Component } from 'react';
import { form, FormGroup, FormControl, InputGroup, Glyphicon, ControlLabel, Button, Panel, ListGroup, ListGroupItem} from 'react-bootstrap';
import axios from 'axios';

export default class TrackSearch extends Component {
    constructor(props) {
        super(props)
        this.submitForm = this.submitForm.bind(this)
        this.handleChange = this.handleChange.bind(this)
        this.state = {
          songsearch: false,
          songquery: '',
          artistsearch: false,
          artistquery: '',
          albumsearch: false,
          albumquery: '',
          response: '',
        }
    }

    handleChange(e) {
      const target = e.target
      const name = target.name
      const value = target.type === 'checkbox' ?
        target.checked : target.value

        this.setState(state => ({[name] : value}))
    }

    submitForm(e) {
        e.preventDefault()
        var params = []
        if (this.state.songsearch) {
            params.push({"q": this.state.songquery, "type": "track"})
        }
        if (this.state.artistsearch) {
            params.push({"q": this.state.artistquery, "type": "artist"})
        }
        if (this.state.albumquery) {
            params.push({"q": this.state.albumquery, "type": "album"})
        }

        axios.post('/api/v1/search', params)
            .then(res => {this.state.response = JSON.parse(res)})
            .catch(er => {console.log(er)})

    }

    render() {
        const searchForm (
            <div>
            <form onSubmit={this.submitForm}>
                <ControlLabel>Search by song</ControlLabel>
                <FormGroup>
                  <InputGroup>
                    <InputGroup.Addon>
                      <input type="checkbox" name="songsearch" checked={this.state.songsearch} onChange={this.handleChange} />
                    </InputGroup.Addon>
                    <FormControl type="text" name="songquery" value={this.state.songquery} placeholder="Enter a song name..." onChange={this.handleChange} />
                  </InputGroup>
                </FormGroup>
                <ControlLabel>Search by artist</ControlLabel>
                <FormGroup>
                  <InputGroup>
                    <InputGroup.Addon>
                      <input type="checkbox" name="artistsearch" checked={this.state.artistsearch} onChange={this.handleChange} />
                    </InputGroup.Addon>
                    <FormControl type="text" name="artistquery" value={this.state.artistquery} placeholder="Enter an artist..." onChange={this.handleChange} />
                  </InputGroup>
                </FormGroup>
                <ControlLabel>Search by album</ControlLabel>
                <FormGroup>
                  <InputGroup>
                    <InputGroup.Addon>
                      <input type="checkbox" name="albumsearch" checked={this.state.albumsearch} onChange={this.handleChange} />
                    </InputGroup.Addon>
                    <FormControl type="text" name="albumquery" value={this.state.albumquery}  placeholder="Enter an album..." onChange={this.handleChange} />
                  </InputGroup>
                </FormGroup>
                <Button type="submit">
                  Search
                </Button>
            </form>

            {this.state.showResults && searchResults}
            </div>
          )
    const searchResults (
            <Panel collapsible defaultExpanded header="Search results">
              <ListGroup fill>
                {this.state.response.map((track, i) => (
                    <ListGroupItem>
                    {track.name} - {track.artists[0].name}
                    </ListGroupItem>
                ))}
              </ListGroup>
            </Panel>
        )

     return {searchForm};
      }
}
