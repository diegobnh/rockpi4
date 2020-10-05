#ifndef STATES_H_
#define STATES_H_

enum State
{
    STATE_1l,      //index 0
    STATE_2l,
    STATE_3l,
    STATE_4l,
    STATE_1b,
    STATE_2b,    
    STATE_1l1b,
    STATE_1l2b,  
    STATE_2l1b,
    STATE_2l2b,   
    STATE_3l1b,
    STATE_3l2b, 
    STATE_4l1b,
    STATE_4l2b //index 13
};

const char *configs[]={ "0",
		        "0-1",
		        "0-2",
		        "0-3", 
			"4",
		        "4-5",		        
			"0,4",
		        "0,4-5",		       		         
			"0-1,4",
		        "0-1,4-5",		       
			"0-2,4",
		        "0-2,4-5",		         
			"0-3,4",
                        "0-3,4-5"
		       };

#endif // STATES_H_
