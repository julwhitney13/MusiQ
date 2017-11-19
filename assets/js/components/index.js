// Base code from react-dnd example: http://react-dnd.github.io/react-dnd/examples-sortable-simple.html
import React, { Component } from 'react'
import Container from './Container'
import TrackSearch from './TrackSearch'

export default class SortableSimple extends Component {
    constructor(props) {
        super(props)
        this.state = this.props.state
    }

    render() {
        return (
            <div>
                <row>
                    <div style="col-md-8">
                        <h1>
                            Our Queue:
                        </h1>
                        <Container />
                    </div>
                    <div style="col-md-4">
                        <TrackSearch />
                    </div>
                </row>
            </div>
        )
    }
}
