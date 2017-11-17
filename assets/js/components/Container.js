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
        this.moveCard = this.moveCard.bind(this)
        this.state = {
            cards: [
                {
                    id: 1,
                    title: 'Closer',
                    artist: 'Tegan & Sara',
                },
                {
                    id: 2,
                    title: 'Paris',
                    artist: 'Magic Man'
                },
                {
                    id: 3,
                    title: 'The Gambler',
                    artist: 'fun.'
                },
                {
                    id: 4,
                    title: 'Blood Red Blood',
                    artist: 'Voxtrot'
                },
                {
                    id: 5,
                    title: 'If So',
                    artist: 'Atlas Genius',
                },
                {
                    id: 6,
                    title: 'R U Mine?',
                    artist: 'Arctic Monkeys',
                },
            ],
        }
    }

    moveCard(dragIndex, hoverIndex) {
        const { cards } = this.state
        const dragCard = cards[dragIndex]

        this.props.channel.push("cards", cards)
            .receive("ok", state =>
                this.setState(
                    update(this.state, {
                        cards: {
                            $splice: [[dragIndex, 1], [hoverIndex, 0, dragCard]],
                        },
                    }),
                )
            )
    }


    render() {
        const { cards } = this.state

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
                    />
                ))}
            </div>
        )
    }
}