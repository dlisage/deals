import PropTypes from 'prop-types';
import React from 'react';
import { Chart } from "react-google-charts";

const options = {
  title: 'Pipeline Deals Column Chart',
  hAxis: {
    title: 'Deal Stage',
    textStyle : {
      fontSize: 5
    }
  },
  vAxis: { title: 'Deal Value'},
  legend: 'none'
};

export default class DealsColumnChart extends React.Component {
  static propTypes = {
    data: PropTypes.array.isRequired
  };

  /**
   * @param props - Comes from your rails view.
   */
  constructor(props) {
    super(props);

    // How to set initial state in ES6 class syntax
    // https://reactjs.org/docs/state-and-lifecycle.html#adding-local-state-to-a-class
    this.state = { data: this.props.data };
  }

  render() {
    return (
      <div>
        <Chart
          chartType="ColumnChart"
          options = { options }
          width="100%"
          height="400px"
          data={ this.state.data }
        />
      </div>
    );
  }
}
