import React, {Component } from 'react';
import { form, FormGroup, FormControl, InputGroup, Glyphicon, ControlLabel, Button, Panel, ListGroup, ListGroupItem} from 'react-bootstrap';
import axios from 'axios';

export default class TrackSearch extends Component {
    constructor(props) {
        super(props)
        // console.log(this.state)
        // console.log(this.props.state)
        this.submitForm = this.submitForm.bind(this)
        this.handleChange = this.handleChange.bind(this)
        this.addSong = this.addSong.bind(this)
        this.state = {
          songquery: '',
          response: [],
          showResults: false,
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
        params.push({"q": this.state.songquery, "type": "track"})

        axios.post('/api/v1/search', params)
            .then(res => {
                var r = JSON.parse(JSON.stringify(res))
                this.state.response = r.data
                this.state.showResults = true
                this.forceUpdate()
            })
            .catch(er => {console.log(er)})

    }

    addSong(track_id, track_artist, track_title) {
        var track_object =  {
            title: track_title,
            id: track_id,
            artist: track_artist,
        }
        this.props.state.cards.push(track_object)

        this.props.channel.push("cards", this.props.state)
            .receive("ok", state => {
                console.log("Pushed cards" + state)
                this.forceUpdate()
            })
            .receive("error", resp => {console.log("Unable to push add song", resp)})


    }

    render() {
        var searchResults

        if (this.state.showResults) {
            searchResults = (
                    <Panel collapsible defaultExpanded bsStyle="success" header="Search results">
                      <ListGroup fill>
                        {this.state.response.map((track, i) => (
                            <ListGroupItem key={track.id}>
                            {track.name} - {track.artists[0].name}
                                <Button className="pull-right" bsSize="small" bsStyle="success" onClick={
                                        () => {this.addSong(track.uri, track.artists[0].name, track.name)}}>
                                    Add Song +
                                </Button>
                            </ListGroupItem>
                        ))}
                      </ListGroup>
                    </Panel>
                )
        }

        var searchForm = (
            <div>
            <form onSubmit={this.submitForm}>
                <ControlLabel>Search for a song</ControlLabel>
                <FormGroup>
                    <FormControl type="text" name="songquery" value={this.state.songquery} placeholder="Enter a song name..." onChange={this.handleChange} />
                </FormGroup>
                <Button type="submit">
                  Search
                </Button>
            </form>

            {searchResults}
            </div>
          )
          return searchForm;
    }
}
