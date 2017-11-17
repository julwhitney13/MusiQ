import React, {Component } from 'react';
import { form, FormGroup, FormControl, InputGroup, Glyphicon, ControlLabel, Button} from 'react-bootstrap';

export default class TrackSearch extends Component {
    constructor(props) {
        super(props)
    }

    render() {
        return (
            <form>
                <ControlLabel>Track Search</ControlLabel>
                <FormGroup>
                  <InputGroup>
                    <FormControl type="text" label="track" placeholder="Enter a song name..."/>
                    <InputGroup.Addon>
                      <Glyphicon glyph="music" />
                    </InputGroup.Addon>
                  </InputGroup>
                </FormGroup>

                <Button type="submit">
                  Search
                </Button>
            </form>
          )
      }
}
