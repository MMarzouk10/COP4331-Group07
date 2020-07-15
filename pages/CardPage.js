import React from 'react';

import faq from '../components/faq';
import LoggedInName from '../components/LoggedInName';
import CardUI from '../components/CardUI';

const CardPage = () =>
{
    return(
        <div>
          <faq/>
            <LoggedInName />
            <CardUI />
        </div>
    );
}

export default CardPage;
