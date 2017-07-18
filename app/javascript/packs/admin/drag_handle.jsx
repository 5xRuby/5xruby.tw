import {SortableHandle} from 'react-sortable-hoc';
import React from 'react';

const DragHandle = SortableHandle(() =>
  <span className="glyphicon glyphicon-menu-hamburger"></span>
  );
export default DragHandle;
