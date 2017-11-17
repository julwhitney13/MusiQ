import React, {Component } from 'react';
import { form, FormGroup, FormControl, InputGroup, Glyphicon, ControlLabel} from 'react-bootstrap';

export default class TrackSearch extends Component {
    constructor(props) {
        super(props)
    }

    render() {
        return (
            <form>
                <FormGroup>
                  <InputGroup>
                    <ControlLabel>Track Search</ControlLabel>
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
