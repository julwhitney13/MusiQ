import React, {Component } from 'react';
import { Navbar, Nav, NavItem} from 'react-bootstrap';

export default class MusiqNavbar extends Component {
    constructor(props) {
        super(props)
    }

    render() {
        return (
          <Navbar inverse>
            <Navbar.Header>
              <Navbar.Brand>
                <a href="#">MusiQ</a>
              </Navbar.Brand>
            </Navbar.Header>
            <Nav>
              <NavItem eventKey={1} href="/groups">Groups</NavItem>
              <NavItem eventKey={2} href="#">Other Link</NavItem>
            </Nav>
          </Navbar>
          )
      }
}
