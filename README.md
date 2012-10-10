A category of NSObject that allows you to create objects from dictionary.

## Getting Started

1. Add NSObject+BITObject folder into your project.
2. Import NSObject+BITObject.h.
3. Start using the only method available for it.

## Example Usage

Say you have a dictionary that if you output to the console looks like this:

``` objective-c
{
    superheros =     (
                {
            age = 35;
            isDead = 1;
            name = Batman;
            powers =             (
                                {
                    elements =                     (
                        metal,
                        air
                    );
                    name = batmobile;
                },
                                {
                    elements =                     (
                        metal
                    );
                    name = batarang;
                }
            );
        },
                {
            age = 30;
            isDead = 0;
            name = Superman;
            powers =             (
                                {
                    elements =                     (
                        fire,
                        metal
                    );
                    name = "laser eye";
                },
                                {
                    elements =                     (
                        air
                    );
                    name = fly;
                }
            );
        }
    );
}
```

Before we can convert this dictionary into an object, we'll need to create classes and properties that correlate to the dictionary keys.

First, we need a base object that contains an array of superheros. So, we create a class called, for example,  JusticeLeague with an array property that will contain the superheros.

``` objective-c
@interface JusticeLeague : NSObject

@property (strong, nonatomic) NSArray *superheros;

@end
```

Then, the Superhero class.

``` objective-c
@interface Superhero : NSObject

@property (strong, nonatomic) NSString *name;
@property (unsafe_unretained, nonatomic) NSInteger age;
@property (unsafe_unretained, nonatomic) BOOL isDead;
@property (strong, nonatomic) NSArray *powers;

@end
```

Finally, the Power class.

``` objective-c
@interface Power : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *elements;

@end
```

Now, we can start using it. First, we allocate and initialize an instance of JusticeLeague. Then, we call the setPropertyValuesWithDictionary method. And voila...we have ourselves a JusticeLeague object with all properties created from the dictionary values.

``` objective-c
JusticeLeague *league = [[[JusticeLeague alloc] init] autorelease];
[league setPropertyValuesWithDictionary:dictionary];
NSLog(@"%@", [[[league superheros] objectAtIndex:0] name]);	//This will be "Batman"
```
