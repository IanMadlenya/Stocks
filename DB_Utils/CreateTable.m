% Simple function to create a MYSQL table with parameters defined here

function nil = CreateTable(tablename)

% might want schema in params
% might want to have multiple possibilities for table creation

tablename = strrep(tablename,' ','_');

switch upper(tablename)
    case 'STOCK_STATUS'
        start = datestr(params('start date'),'yyyy-mm-dd');
        cmd = [...
              'CREATE TABLE status (',...                            
              'ticker        VARCHAR(8) UNIQUE ,',...                       % Ticker
              'filled_to     DATE DEFAULT "',start,'",',...                 % Date the table has been updated until
              'analyzed_to   DATE DEFAULT "',start,'",',...                 % Date the table has been analyzed until
              'trend         INT(5) DEFAULT 0,',...                         % Trend indicator of trend length and direction
              'trend_mag     DECIMAL(10,3) DEFAULT 0,',...                  % Percent change from trend origination
              'typ_trend_mag DECIMAL(10,3) DEFAULT 0',...                   % Normal trend amount
              ')'];
        cmd2 = 'CREATE INDEX tickerIDX ON status (ticker)';
              
        
    otherwise
        cmd =[...
            'CREATE TABLE ',tablename,' ('...
            'date     DATE default NULL,',...
            'open     DECIMAL(10,3) NOT NULL,',...
            'close    DECIMAL(10,3) NOT NULL,',...
            'adjclose DECIMAL(10,3) NOT NULL,',...
            '52_low   DECIMAL(10,3) NOT NULL DEFAULT 0,'...
            '52_high  DECIMAL(10,3) NOT NULL DEFAULT 0,',...
            '50_day_average DECIMAL(10,3) NOT NULL DEFAULT 0,',...
            '200_day_average DECIMAL(10,3) NOT NULL DEFAULT 0)'
            ];
        cmd2 = ['CREATE INDEX dateIDX on ',tablename,' (date)'];
        
end

fprintf(params('output'),['\nCreating Table ',tablename,'\n'])

mysql(cmd)

end

