import React, {Component } from 'react';
import { form, FormGroup, FormControl, InputGroup, Glyphicon} from 'react-bootstrap';

export default class TrackSearch extends Component {
    constructor(props) {
        super(props)
    }

    render() {
        return (
            <form>
                <FormGroup>
                  <InputGroup>
                    <FormControl type="text" label="Song" placeholder="Enter a song name..."/>
                    <InputGroup.Addon>
                      <Glyphicon glyph="music" />
                    </InputGroup.Addon>
                  </InputGroup>
                </FormGroup>
            </form>
          )
      }
}
