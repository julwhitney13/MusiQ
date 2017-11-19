// Base code from react-dnd example: http://react-dnd.github.io/react-dnd/examples-sortable-simple.html
import React, { Component } from 'react'
import Container from './Container'
import TrackSearch from './TrackSearch'

export default class SortableSimple extends Component {
    constructor(props) {
        super(props)
        // console.log(props)
        // console.log(this.props.state)
        this.state = this.props.state
        // this.state = {"cards":[]}
    }

    render() {
        return (
            <div>
                <div className="col-md-8">
                    <h3>
                        Our Queue:
                    </h3>
                    <Container state={this.state}/>
                </div>
                <div className="col-md-4">
                    <h3>
                        Add a Song:
                    </h3>
                    <TrackSearch />
                </div>
            </div>
        )
    }
}
