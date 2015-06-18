#ifdef DEBUG
#define DebugLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DebugLog( s, ... )
#endif



#define CONSUMER_KEY @"" // !! Define key here
#define CONSUMER_SECRET @"" //Define key here
#define TOKEN_REQUEST_URL @"https://api.twitter.com/oauth2/token"
#define SEARCH_REQUEST_URL @"https://api.twitter.com/1.1/search/tweets.json"



#define GLOBAL_CELL_HEIGHT 120
#define HEADER_COLOR [UIColor colorWithRed:0.38/1.5 green:0.73/1.5 blue:0.85/1.5 alpha:0.7]
#define CELL_EVEN_COLOR [UIColor colorWithRed:0.38 green:0.73 blue:0.85 alpha:1.0]
#define CELL_ODD_COLOR [UIColor colorWithRed:0.38/1.3 green:0.73/1.3 blue:0.85/1.3 alpha:1.0]
#define CELL_TEXT_COLOR [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]
#define BACKGROUND_COLOR [UIColor colorWithRed:0.38/2 green:0.73/2 blue:0.85/2 alpha:1.0]
#define BACKGROUND_LABEL_COLOR [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0]
