// Base code from react-dnd example: http://react-dnd.github.io/react-dnd/examples-sortable-simple.html
import React, { Component } from 'react'
import update from 'immutability-helper'
import { DragDropContext } from 'react-dnd'
import HTML5Backend from 'react-dnd-html5-backend'
import Card from './Card'

const style = {
    width: 400,
}

@DragDropContext(HTML5Backend)
export default class Container extends Component {
    constructor(props) {
        super(props)
        console.log(props)
        console.log(this.props.state)
        this.moveCard = this.moveCard.bind(this)
        this.removeCard = this.removeCard.bind(this)
        this.state = this.props.state
    }

    moveCard(dragIndex, hoverIndex) {
        const { cards } = this.state
        const dragCard = cards[dragIndex]
        this.setState(
            update(this.state, {
                cards: {
                    $splice: [[dragIndex, 1], [hoverIndex, 0, dragCard]],
                },
            }),
        )
        this.props.channel.push("cards", this.state)
            .receive("ok", state => {
                console.log("in set state" + state)}
            )
            .receive("error", resp => {console.log("Unable to push change song", resp)})
    }

    removeCard(index) {
        this.state.cards.pop(index)
        this.setState({
            cards: this.state.cards
        })
        this.props.channel.push("cards", this.state)
            .receive("ok", state => {console.log("Deleted song")})
            .receive("error", resp => {console.log("Unable to delete song", resp)})
        this.forceUpdate()
    }

    render() {
        const { cards } = this.state
        console.log("Re-rendering cards")

        return (
            <div style={style}>
                {cards.map((card, i) => (
                    <Card
                        key={card.id}
                        index={i}
                        id={card.id}
                        title={card.title}
                        artist={card.artist}
                        moveCard={this.moveCard}
                        removeCard={this.removeCard}
                    />
                ))}
            </div>
        )
    }
}
