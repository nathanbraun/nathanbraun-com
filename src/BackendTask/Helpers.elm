module BackendTask.Helpers exposing (BTask, routes)

import BackendTask exposing (BackendTask)
import BackendTask.Glob as Glob
import FatalError
import Types exposing (RouteParams)


type alias BTask v =
    BackendTask FatalError.FatalError v


routes : BTask (List RouteParams)
routes =
    content
        |> BackendTask.map
            (List.map
                (\contentPage ->
                    { splat = contentPage }
                )
            )


content : BTask (List (List String))
content =
    Glob.succeed
        (\leadingPath last ->
            if last == "index" then
                leadingPath

            else
                leadingPath ++ [ last ]
        )
        |> Glob.match (Glob.literal "content/")
        |> Glob.capture Glob.recursiveWildcard
        |> Glob.match (Glob.literal "/")
        |> Glob.capture Glob.wildcard
        |> Glob.match (Glob.literal ".md")
        |> Glob.toBackendTask
