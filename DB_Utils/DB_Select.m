% Function to put lots of Database Select statements.
% The goal is to keep SQL logic out of the application logic as much as
% possible.
% In addition, these statemnts should be eventually ported to MySQL
% stored procedures for speed purposes. Oh well, for later.

function output = DB_Select(type,spec,condition)


switch strrep(upper(type),'_',' ')
    % Simplest one, get "Filled To" date for a given ticker
    case 'FILLED TO'
        cmd = [...
            'SELECT Filled_To FROM status WHERE( Ticker = "',spec,'")'
            ];
    
    case 'STATS TO'
        cmd = [...
            'SELECT Stats_To FROM status WHERE( Ticker = "',spec,'")'
            ];
    
    case 'TREND TO'
        cmd = [...
            'SELECT Trend_To FROM status WHERE( Ticker = "',spec,'")'
            ];
    
    case 'COUNT'
        cmd = [...
            'SELECT COUNT(*) FROM ',spec ...
            ];
    
    case '50AVG'
        cmd = [...
            'SELECT SUM(close)/count(*) FROM ',...
            spec,' WHERE(',...
            'date <= "',condition,'" and ',...
            'date >= SUBDATE("',condition,'",INTERVAL 50 DAY))'...
            ];
        
 % 200 Day Average
    case '200AVG'
        cmd = [...
            'SELECT SUM(close)/count(*) FROM ',...
            spec,' WHERE(',...
            'date <= "',condition,'" and ',...
            'date >= SUBDATE("',condition,'",INTERVAL 200 DAY))'...
            ];
 % 52 Week Maximum        
    case '52MAX'
        cmd = [...
            'SELECT MAX(close) FROM ',...
            spec,' WHERE(',...
            'date <= "',condition,'" and ',...
            'date >= SUBDATE("',condition,'",INTERVAL 52 WEEK))'...
            ];
 
 % 52 Week Minimum
    case '52MIN'
        cmd = [...
            'SELECT MIN(close) FROM ',...
            spec,' WHERE(',...
            'date <= "',condition,'" and ',...
            'date >= SUBDATE("',condition,'",INTERVAL 52 WEEK))'...
            ];
    
 % 52 Weeks Worth of Closing Prices 
    case '52CLOSE'
        cmd = [...
            'SELECT (close) FROM ',...
            spec,' WHERE(',...
            'date <= "',condition,'" and ',...
            'date >= SUBDATE("',condition,'",INTERVAL 52 WEEK))'...
            ];
        
 % Current Trend Direction
    case 'CURRENT TREND'
        cmd = [...
            'SELECT trend FROM status WHERE ',...
            'ticker = "',spec,'"',...
            ];
        
        
        
            
        
    otherwise
        fprintf(2,'SNAP!, Unknown Database Selection Request!\n')
        dbstack(2,'-completenames')
        
end

output = mysql(cmd);






end











