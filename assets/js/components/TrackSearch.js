import React, {Component } from 'react';
import { form, FormGroup, FormControl, InputGroup, Glyphicon, ControlLabel, Button} from 'react-bootstrap';

export default class TrackSearch extends Component {
    constructor(props) {
        super(props)
    }

    render() {
        return (
            <form>
                <ControlLabel>Song</ControlLabel>
                <FormGroup>
                  <InputGroup>
                    <InputGroup.Addon>
                      <input type="checkbox" aria-label="songsearch" />
                    </InputGroup.Addon>
                    <FormControl type="text" label="track" placeholder="Enter a song name..."/>
                  </InputGroup>
                </FormGroup>
                <ControlLabel>Artist</ControlLabel>
                <FormGroup>
                  <InputGroup>
                    <InputGroup.Addon>
                      <input type="checkbox" aria-label="artistsearch" />
                    </InputGroup.Addon>
                    <FormControl type="text" label="artist" placeholder="Enter an artist..."/>
                  </InputGroup>
                </FormGroup>
                <ControlLabel>Album</ControlLabel>
                <FormGroup>
                  <InputGroup>
                    <InputGroup.Addon>
                      <input type="checkbox" aria-label="songsearch" />
                    </InputGroup.Addon>
                    <FormControl type="text" label="album" placeholder="Enter an album..."/>
                  </InputGroup>
                </FormGroup>
                <Button type="submit">
                  Search
                </Button>
            </form>
          )
      }
}
