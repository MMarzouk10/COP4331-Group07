import React from 'react';

import Faq from '../components/Faq';
import LoggedInName from '../components/LoggedInName';
import CardUI from '../components/CardUI';

const CardPage = () =>
{
    return(
        <div>
          <Faq/>
            <LoggedInName />
            <CardUI />
        </div>
    );
}

export default CardPage;
