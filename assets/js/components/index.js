// Base code from react-dnd example: http://react-dnd.github.io/react-dnd/examples-sortable-simple.html
import React, { Component } from 'react'
import Container from './Container'
import TrackSearch from './TrackSearch'
import axios from 'axios';
import {Row, Button, ButtonGroup, Col} from 'react-bootstrap';

export default class SortableSimple extends Component {
    constructor(props) {
        super(props)
        this.state = this.props.state
        this.update_queue = this.update_queue.bind(this)
        this.next_song = this.next_song.bind(this)
        this.props.channel.on("newQueue", this.update_queue)
        this.props.channel.on("play", this.play_song)
        this.props.channel.on("pause", this.pause_song)
        this.props.channel.on("next", this.next_song)
    }

    update_queue(new_queue) {
        this.setState(new_queue)
    }

    play_song() {
        axios.post("/api/v1/play", {})
            .then(res => {console.log("Played successfully", res)})
            .catch(er => {console.log("Error playing song", er)})
    }

    pause_song() {
        axios.post("/api/v1/pause", {})
            .then(res => {console.log("Paused successfully", res)})
            .catch(er => {console.log("Error pausing song", er)})
    }

    next_song() {
        axios.post("/api/v1/next", {})
            .then(res => {console.log("Went to next song successfully", res)})
            .catch(er => {console.log("Error going to next song", er)})
        if (this.state.cards.length > 0) {
            this.state.cards.shift()
            this.setState({
                cards: this.state.cards
            })
            this.props.channel.push("cards", this.state)
                .receive("ok", state => {
                    console.log("in set state" + state)}
                )
                .receive("error", resp => {console.log("Unable to push change song", resp)})
            console.log(this.state.cards)
        }
    }

    render() {
        console.log(this.state)
        return (
            <div>
            <Row className="text-center">
                <ButtonGroup>
                    <Button bsStyle="primary" onClick={() => this.props.channel.push("play", {})}>Play</Button>
                    <Button bsStyle="info" onClick={() => this.props.channel.push("pause", {})}>Pause</Button>
                    <Button bsStyle="primary" onClick={() => this.props.channel.push("next", {})}>Next</Button>
                </ButtonGroup>
            </Row>
            <Row>
                <Col md={1} />
                <Col md={5} >
                    <h3>
                        Our Queue:
                    </h3>
                    <Container state={this.state} channel={this.props.channel}/>
                </Col>
                <Col md={5} >
                    <h3>
                        Add a Song:
                    </h3>
                    <TrackSearch state={this.state} channel={this.props.channel}/>
                </Col>
                <Col md={1} />
            </Row>
            </div>
        )
    }
}
