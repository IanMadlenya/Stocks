% Perform 2A Processing
% Analyze Raw data to obtain basic statistics about it. 
% No Probability insight yet

function status = Perform2AProcessing(tickers)

for ii = 1:length(tickers)
    ticker = tickers{ii};
    
    fprintf(params('logID'),['Performing basic statistical analysis on\t',ticker,'\n\n'])
    
    
    
    %% Until The Analyzed Data Has Caught Up to the  Filled To Data
    while DB_Select('Stats to',ticker) < DB_Select('filled to',ticker)
        
        
        % Get Basic Stats
        Stats_to = DB_Select('Stats To',ticker);
        Stats_to_formatted = datestr(Stats_to,'yyyy-mm-dd');
         
        AVG50   = DB_Select('50avg',ticker, Stats_to_formatted);
        AVG200  = DB_Select('200avg',ticker, Stats_to_formatted);
        MAX52   = DB_Select('52max',ticker, Stats_to_formatted);
        MIN52   = DB_Select('52min',ticker, Stats_to_formatted);
        
        if (isnan(AVG50) || isnan(AVG200) || isnan(MAX52) || isnan(MIN52))
            status = DB_Update('Stats To',ticker,datestr(Stats_to + 1,'yyyy-mm-dd'));
            continue
        end
        
        % Update Ticker Table
        status = DB_Update('50avg', ticker,AVG50, Stats_to_formatted);
        status = DB_Update('200avg',ticker,AVG200,Stats_to_formatted);
        status = DB_Update('52max', ticker,MAX52, Stats_to_formatted);
        status = DB_Update('52min', ticker,MIN52, Stats_to_formatted);
        
        
        % Update Status Table
        status = DB_Update('Stats To',ticker,datestr(Stats_to + 1,'yyyy-mm-dd'));
        
        
    end
    
    
    
    
    
    
    
    
end


end





