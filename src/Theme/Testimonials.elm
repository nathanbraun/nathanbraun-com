module Theme.Testimonials exposing (view)

import Components.Heading
import Components.Link
import Components.Testimonial
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes as Attr exposing (css)
import Markdown.Block as Block
import Tailwind.Breakpoints as Bp
import Tailwind.Utilities as Tw


type Size
    = M
    | L


type alias Quote msg =
    { content : List (Html msg)
    , name : String
    , size : Size
    , front : Bool
    , mobile : Bool
    }


view : Bool -> Html msg
view frontOnly =
    let
        quotes_ =
            if frontOnly then
                quotes |> List.filter .front

            else
                quotes
    in
    div []
        [ div [ css [ Tw.text_center ] ]
            [ Components.Heading.new
                { level =
                    Block.H2
                , rawText = "What People Are Saying"
                , children = [ div [] [ text "What People Are Saying" ] ]
                }
                |> Components.Heading.view
            ]
        , div [ css [ Tw.text_center ] ]
            [ text "About this and related "
            , Components.Link.new { content = [ text "other sport" ], destination = "/bundle" } |> Components.Link.view
            , text " versions — "
            ]
        , div
            [ css
                [ Tw.w_full
                , Tw.flex
                , Tw.items_center
                , Tw.justify_center
                ]
            ]
            [ div
                [ css
                    [ Tw.grid
                    , Tw.gap_4
                    , Tw.mt_8
                    , Tw.max_w_full
                    , Bp.xxxxl
                        [ Tw.grid_cols_7
                        ]
                    , Bp.xxxl
                        [ Tw.grid_cols_6
                        ]
                    , Bp.xxl
                        [ Tw.grid_cols_5
                        ]
                    , Bp.xl
                        [ Tw.grid_cols_4
                        ]
                    , Bp.lg
                        [ Tw.grid_cols_3
                        ]
                    , Bp.sm
                        [ Tw.grid_cols_2
                        , Tw.mx_6
                        ]
                    , Tw.gap_y_4
                    , Tw.my_8
                    , Tw.mx_0
                    , Tw.grid_cols_1
                    ]
                ]
                (quotes_
                    |> List.map quoteToTestimonialComponent
                )
            ]
        ]


quoteToTestimonialComponent : Quote msg -> Html msg
quoteToTestimonialComponent quote =
    let
        subset =
            { content = quote.content, name = quote.name, mobile = quote.mobile }
    in
    case quote.size of
        L ->
            subset
                |> Components.Testimonial.new
                |> Components.Testimonial.withLarge
                |> Components.Testimonial.view

        M ->
            subset
                |> Components.Testimonial.new
                |> Components.Testimonial.view


quotes : List (Quote msg)
quotes =
    [ { content =
            [ p []
                [ text "\"The book here was "
                , strong [ css [ Tw.font_bold ] ] [ text "really, really well done..." ]
                , text "...\""
                ]
            ]
      , name = "Bill Connelly"
      , size = M
      , front = True
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"This is amazingly awesome. I’ve recently slowly crept into data science driven by a pet passion for fantasy sport analytics. ..."
                , strong [ css [ Tw.font_bold ] ] [ text "the way the learning is framed here is 10x what you’ll get someplace else." ]
                , text "...\""
                ]
            ]
      , name = "u/Nick58"
      , size = L
      , front = True
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"...probably the "
                , strong [ css [ Tw.font_bold ] ] [ text "best / most complete Pandas walk through I've seen" ]
                , text ".\""
                ]
            ]
      , name = "Bill S"
      , size = M
      , front = True
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"I really loved your book. You did an amazing job on it. ... I've been "
                , strong [ css [ Tw.font_bold ] ] [ text "trying to get my son more into programming, and your book has been perfect... really clicked for him." ]
                , text "\""
                ]
            ]
      , name = "John M"
      , size = L
      , front = True
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"Fantastic... literally "
                , strong [ css [ Tw.font_bold ] ] [ text "feels like it was written for me!" ]
                , text "\""
                ]
            ]
      , name = "u/MurrayInBocaRaton"
      , size = M
      , front = True
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"..."
                , strong [ css [ Tw.font_bold ] ] [ text "picked up more, and at a better pace" ]
                , text ", using this than a lot of the free online tools I’d been trying the past few months.\""
                ]
            ]
      , name = "Ryan P"
      , size = M
      , front = True
      , mobile = False
      }
    , { content =
            [ p []
                [ text "\"Love the book... "
                , strong [ css [ Tw.font_bold ] ] [ text "My python has come a very long way thanks to you." ]
                , text "\""
                ]
            ]
      , name = "u/TomatoHead7"
      , size = M
      , front = True
      , mobile = False
      }
    , { content =
            [ p []
                [ text "\"I have always wanted to learn a language but always seemed to get discouraged by the 'Hello World' chapters that were never ending. I like that your book cuts out the riff raff and teaches the important things! "
                , strong [ css [ Tw.font_bold ] ] [ text "I'm flying through the book and feel like I'm learning a ton!" ]
                , text " Best wishes from a satisfied customer.\""
                ]
            ]
      , name = "Jason K"
      , size = L
      , front = True
      , mobile = False
      }
    , { content =
            [ p []
                [ text "\""
                , strong [ css [ Tw.font_bold ] ] [ text "I have tons of coding books. Yours is a favorite" ]
                , text "\""
                ]
            ]
      , name = "Craig M"
      , size = M
      , front = True
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"Dear Nate, I'd like to thank you for a "
                , strong [ css [ Tw.font_bold ] ] [ text "brilliant book" ]
                , text ". ... It's distilled, "
                , strong [ css [ Tw.font_bold ] ] [ text "without extra and unnecessary...  info and challenging at the same time" ]
                , text ". I'm writing you just to thank you.\""
                ]
            ]
      , name = "Murat S"
      , size = L
      , front = True
      , mobile = False
      }
    , { content =
            [ p []
                [ text "\""
                , strong [ css [ Tw.font_bold ] ]
                    [ text "Loving this so far!\""
                    ]
                , text "\""
                ]
            ]
      , name = "Steve S"
      , size = M
      , front = True
      , mobile = False
      }
    , { content =
            [ p []
                [ text "\"...much more engaging for me personally because it’s info I’m interested in. I’ve taken automate the boring stuff, python for finance, etc and while those courses are great.. "
                , strong [ css [ Tw.font_bold ] ] [ text "I seem to be understanding it better because its about a subject I like" ]
                , text ".\""
                ]
            ]
      , name = "u/financenstuff"
      , size = L
      , front = True
      , mobile = False
      }
    , { content =
            [ p []
                [ text "\"..."
                , strong [ css [ Tw.font_bold ] ] [ text "exactly the course I was looking for" ]
                , text " a long time! :)\""
                ]
            ]
      , name = "Marco C"
      , size = M
      , front = True
      , mobile = False
      }
    , { content =
            [ p []
                [ text "\"I "
                , strong [ css [ Tw.font_bold ] ] [ text "really like your approach to teaching data science!" ]
                , text " I usually work with... R, and your book is one of the resources I'm using to teach myself Python... "
                , strong [ css [ Tw.font_bold ] ] [ text "So far it's the best one!" ]
                , text "\""
                ]
            ]
      , name = "Hanwei S"
      , size = L
      , front = True
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"The only Python course that's kept me "
                , strong [ css [ Tw.font_bold ] ] [ text "engaged from beginning to end" ]
                , text ".\""
                ]
            ]
      , name = "Michael G"
      , size = M
      , front = True
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"Been loving your book so far, it progresses at a great pace and has "
                , strong [ css [ Tw.font_bold ] ] [ text "easily been the best mode I've used to understand coding" ]
                , text ". I'm excited to learn more, thank you for creating this book that's "
                , strong [ css [ Tw.font_bold ] ] [ text "allowing me to have fun learning again" ]
                , text ", it's been ages.\""
                ]
            ]
      , name = "Kevin B"
      , size = L
      , front = True
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"..."
                , strong [ css [ Tw.font_bold ] ] [ text "absolutely superb" ]
                , text "... definitely understand the acclamation\""
                ]
            ]
      , name = "Jaeho Y"
      , size = M
      , front = True
      , mobile = False
      }
    , { content =
            [ p []
                [ text "\"..."
                , strong [ css [ Tw.font_bold ] ] [ text "really helpful and a fun way to learn" ]
                , text ".\""
                ]
            ]
      , name = "Brian D"
      , size = M
      , front = True
      , mobile = False
      }
    , { content =
            [ p []
                [ text "\"You're an "
                , strong [ css [ Tw.font_bold ] ] [ text "absolute legend!" ]
                , text "\""
                ]
            ]
      , name = "Durand S"
      , size = M
      , front = True
      , mobile = False
      }
    , { content =
            [ p []
                [ text "\"I am enjoying refreshing my Python knowledge with your book very much.\""
                ]
            ]
      , name = "Dan V"
      , size = M
      , front = True
      , mobile = False
      }
    , { content =
            [ p []
                [ text "\"I am going through your book right now... and "
                , strong [ css [ Tw.font_bold ] ] [ text "I love it" ]
                , text "!\""
                ]
            ]
      , name = "Cinoon B"
      , size = M
      , front = True
      , mobile = False
      }
    , { content =
            [ p []
                [ text "\""
                , strong [ css [ Tw.font_bold ] ] [ text "I bought LTCWFF and love it!" ]
                , text "\""
                ]
            ]
      , name = "Todd B"
      , size = M
      , front = True
      , mobile = False
      }
    , { content =
            [ p []
                [ text "\"...so helpful and "
                , strong [ css [ Tw.font_bold ] ] [ text "enjoyable" ]
                , text ".\""
                ]
            ]
      , name = "Ryan C"
      , size = M
      , front = True
      , mobile = False
      }
    , { content =
            [ p []
                [ text "\"The book is "
                , strong [ css [ Tw.font_bold ] ] [ text "great!" ]
                , text "\""
                ]
            ]
      , name = "Steffen L"
      , size = M
      , front = True
      , mobile = False
      }
    , { content =
            [ p []
                [ text "\"... "
                , strong [ css [ Tw.font_bold ] ] [ text "helped me way more than my grad school class did" ]
                , text ".\""
                ]
            ]
      , name = "Glen I"
      , size = M
      , front = True
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"Thank you Nathan ... You ARE an "
                , strong [ css [ Tw.font_bold ] ] [ text "amazing teacher" ]
                , text "!\""
                ]
            ]
      , name = "Urshita G"
      , size = M
      , front = True
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"Can I just say that is the "
                , strong [ css [ Tw.font_bold ] ] [ text "simplest" ]
                , text " and "
                , strong [ css [ Tw.font_bold ] ] [ text "best" ]
                , text " explanation I have ever seen... Awesome!!\""
                ]
            ]
      , name = "Stu T"
      , size = M
      , front = True
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"I was amazed by how you "
                , strong [ css [ Tw.font_bold ] ] [ text "broke down complicated concepts" ]
                , text " and made them easier to understand.\""
                ]
            ]
      , name = "Ryan C"
      , size = M
      , front = True
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"I can't tell you how many times I've tried to get into programming and gave up because it was so dry. "
                , strong [ css [ Tw.font_bold ] ] [ text "This has been such a nice change of pace and I'm loving it" ]
                , text ".\""
                ]
            ]
      , name = "Paval M"
      , size = M
      , front = True
      , mobile = False
      }
    , { content =
            [ p []
                [ text "\"I just bought your book and have to say "
                , strong [ css [ Tw.font_bold ] ] [ text "I enjoy it immensely so far." ]
                , text "\""
                ]
            ]
      , name = "Tim Y"
      , size = M
      , front = True
      , mobile = False
      }
    , { content =
            [ p []
                [ text "\"..."
                , strong [ css [ Tw.font_bold ] ] [ text "exactly what I needed" ]
                , text " to finally get past tutorial hell and apply Python to something I love.\""
                ]
            ]
      , name = "Philip D"
      , size = M
      , front = True
      , mobile = False
      }
    , { content =
            [ p []
                [ text "\"it's been great refreshers for basic Python... "
                , strong [ css [ Tw.font_bold ] ] [ text "I appreciate the Anki cards" ]
                , text " ... they're helping cement the terminology...\""
                ]
            ]
      , name = "u/michaelmanieri"
      , size = L
      , front = True
      , mobile = False
      }
    , { content =
            [ p []
                [ text "\"...it helped me tremendously ... "
                , strong [ css [ Tw.font_bold ] ] [ text "I wouldn't be where I'm at with the Python language today without this book to kick start things." ]
                , text "\""
                ]
            ]
      , name = "u/F1rstxLas7"
      , size = M
      , front = True
      , mobile = False
      }
    , { content =
            [ p []
                [ text "\"..."
                , strong [ css [ Tw.font_bold ] ] [ text "very engaging" ]
                , text " so far compared to some of the other online resources I've tried to pick this up with.\""
                ]
            ]
      , name = "Tim M"
      , size = M
      , front = True
      , mobile = False
      }
    , { content =
            [ p []
                [ text "\"..."
                , strong [ css [ Tw.font_bold ] ] [ text "could not be more satisfied with the content" ]
                , text ". ...it has been great to work through your in-depth examples learning new skills. I had a previous interest in this sort of analysis and have had intermediate programming experience, but never could tie the two together.\""
                ]
            ]
      , name = "Owen B"
      , size = L
      , front = True
      , mobile = False
      }
    , { content =
            [ p []
                [ text "\"Incredible work! Bought it right away. Only 3 chapters in and "
                , strong [ css [ Tw.font_bold ] ] [ text "this book is already better than expected" ]
                , text ". Worth every penny. Thank you!\""
                ]
            ]
      , name = "u/TheMotizzle"
      , size = L
      , front = True
      , mobile = False
      }
    , { content =
            [ p []
                [ text "\"...recently bought Learn to Code with Baseball and am "
                , strong [ css [ Tw.font_bold ] ] [ text "thoroughly enjoying it" ]
                , text " and learning some new things along the way...\""
                ]
            ]
      , name = "Lennart R"
      , size = M
      , front = False
      , mobile = False
      }
    , { content =
            [ p []
                [ text "\"It is really cool and I enjoy learning Python with it...\""
                ]
            ]
      , name = "Phillipp K"
      , size = M
      , front = False
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"...an excellent resource. "
                , strong [ css [ Tw.font_bold ] ] [ text "I like your writing style and the projects are fun and make it easy to learn" ]
                , text ".\""
                ]
            ]
      , name = "James H"
      , size = M
      , front = False
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"I’ve been "
                , strong [ css [ Tw.font_bold ] ] [ text "greatly enjoying" ]
                , text " the content so far!\""
                ]
            ]
      , name = "Monica S"
      , size = M
      , front = False
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"Love the book...\""
                ]
            ]
      , name = "Christiaan B"
      , size = M
      , front = False
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"One of my friends started on his coding for fantasy football journey using your book and "
                , strong [ css [ Tw.font_bold ] ] [ text "he loves it" ]
                , text "...\""
                ]
            ]
      , name = "Nick W"
      , size = M
      , front = False
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"...the book is "
                , strong [ css [ Tw.font_bold ] ] [ text "very well structured and easy to follow" ]
                , text "... I found it very helpful!\""
                ]
            ]
      , name = "Xiaolu Z"
      , size = M
      , front = False
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"..."
                , strong [ css [ Tw.font_bold ] ] [ text "very informative and good intro to coding" ]
                , text ". Additionally, [Nate] would answer any questions I emailed him within 24 hours. Excellent customer service and pushed new editions to everyone who had already paid. I really appreciate [Nate]’s commitment to his product.\""
                ]
            ]
      , name = "u/ledsdeadbaby"
      , size = L
      , front = False
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"I spent a few minutes going through the charting examples... "
                , strong [ css [ Tw.font_bold ] ] [ text "I really REALLY enjoyed it" ]
                , text ".\""
                ]
            ]
      , name = "Lukas R"
      , size = M
      , front = False
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"I've been fascinated by sports and statistics from a young age... throughout my college career... "
                , strong [ css [ Tw.font_bold ] ] [ text "no professor was able to get me excited about a subject matter like the first 20 pages of [LTCWFF]" ]
                , text "...\""
                ]
            ]
      , name = "Daniel O"
      , size = L
      , front = False
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"...loving it so far. I do not know if it's because I love basketball, you make it so simple to learn, how you approach teaching, or some combination of attributes... "
                , strong [ css [ Tw.font_bold ] ] [ text "will probably be the reason I learn to code" ]
                , text "\""
                ]
            ]
      , name = "Sina K"
      , size = L
      , front = False
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"...your book is great. It's "
                , strong [ css [ Tw.font_bold ] ] [ text "exactly what I needed to motivate me to push through" ]
                , text ".\""
                ]
            ]
      , name = "Matt O"
      , size = M
      , front = False
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"...can definitely recommend it. It's "
                , strong [ css [ Tw.font_bold ] ] [ text "so much easier" ]
                , text " learning coding with a subject that is familiar and one is passionate about. Thank you!\""
                ]
            ]
      , name = "u/scrabas"
      , size = M
      , front = True
      , mobile = False
      }
    , { content =
            [ p []
                [ text "\"..."
                , strong [ css [ Tw.font_bold ] ] [ text "very well put together" ]
                , text ". I've been needing a good excuse to strengthen my pandas and python skills and this looks like the perfect catalyst for me.\""
                ]
            ]
      , name = "Erik W"
      , size = L
      , front = False
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"Its been a "
                , strong [ css [ Tw.font_bold ] ] [ text "great intro into the world of analytics" ]
                , text " for me.\""
                ]
            ]
      , name = "Carson S"
      , size = M
      , front = False
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"First, I'd just like to say how much "
                , strong [ css [ Tw.font_bold ] ] [ text "I love the book" ]
                , text " and truly appreciate that something like this exists... I have been working through a variety of materials (e.g. online courses etc) to try and build my Python skills and get more into the ... field, and "
                , strong [ css [ Tw.font_bold ] ] [ text "this has been tremendously helpful." ]
                , text "\""
                ]
            ]
      , name = "Nick C"
      , size = L
      , front = False
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"I have purchased and started reading your book, it is amazing. I am a beginner in Python and "
                , strong [ css [ Tw.font_bold ] ] [ text "your book is truly... fun" ]
                , text ".\""
                ]
            ]
      , name = "Xavier L"
      , size = M
      , front = False
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"...the book is great! I've been looking for some learning materials for data analysis with the NBA and I'm "
                , strong [ css [ Tw.font_bold ] ] [ text "really enjoying it so far" ]
                , text ".\""
                ]
            ]
      , name = "Eli S"
      , size = M
      , front = False
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"The course is going well. I like how you bring out patterns in the commands, ... "
                , strong [ css [ Tw.font_bold ] ] [ text "Makes it so much easier" ]
                , text ".\""
                ]
            ]
      , name = "Glenn M"
      , size = M
      , front = False
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"Gotta say, this is the most brilliant idea. ... Congrats on the "
                , strong [ css [ Tw.font_bold ] ] [ text "absolutely awesome product." ]
                , text "\""
                ]
            ]
      , name = "Lee C"
      , size = M
      , front = False
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"I really "
                , strong [ css [ Tw.font_bold ] ] [ text "loved" ]
                , text " it!\""
                ]
            ]
      , name = "John C"
      , size = M
      , front = False
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"P.S. Huge fan of the books! Such a "
                , strong [ css [ Tw.font_bold ] ] [ text "great and engaging way to practice analytics" ]
                , text " with a variety of methods on fun subject matters!\""
                ]
            ]
      , name = "Joey P"
      , size = L
      , front = False
      , mobile = True
      }
    , { content =
            [ p []
                [ text "\"I’m flying through your book and loving every bit of it so far. The way you lay everything out is "
                , strong [ css [ Tw.font_bold ] ] [ text "incredibly intuitive and easy to follow" ]
                , text ".\""
                ]
            ]
      , name = "Charlie P"
      , size = L
      , front = True
      , mobile = True
      }
    ]
